#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: buildEnvironmentLoad
# bin: set test
# Docs: o ./docs/_templates/tools/debug.md
# Test: o ./test/tools/debug-tests.sh

#
# Is build debugging enabled?
#
# Usage: {fn} [ moduleName ... ]
# Argument: moduleName - Optional. String. If `BUILD_DEBUG` contains any token passed, debugging is enabled.
# Exit Code: 1 - Debugging is not enabled (for any module)
# Exit Code: 0 - Debugging is enabled
# Environment: BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. BUILD_DEBUG may be a comma-separated list of modules to target debugging.
#
buildDebugEnabled() {
  local debugString
  export BUILD_DEBUG
  # NOTE: This allows runtime changing of this value
  # __environment buildEnvironmentLoad BUILD_DEBUG || return $?
  debugString="${BUILD_DEBUG-}"
  if [ -n "$debugString" ] && [ "$debugString" != "false" ]; then
    [ $# -gt 0 ] || return 0
    debugString=",$debugString,"
    while [ $# -gt 0 ]; do
      [ "${debugString/,$1,/}" = "${debugString}" ] || return 0
      shift
    done
  fi
  return 1
}

# Internal: true
# Usage: {fn} [ setArgs ]
# Turn on debugging and additional `set` arguments
# Actually does 'set -x` - should be only occurrence.
__buildDebugEnable() {
  set "-x${1-}" # Debugging
}

# Usage: {fn} [ setArgs ]
# Turn off debugging and additional `set` arguments
# Internal: true
__buildDebugDisable() {
  set "+x${1-}" # Debugging off
}

#
# Start build debugging if it is enabled.
# This does `set -x` which traces and outputs every shell command
# Use it to debug when you can not figure out what is happening internally.
#
# `BUILD_DEBUG` can be a list of strings like `environment,assert` for example.
# Environment: BUILD_DEBUG
# Usage: {fn} [ moduleName ... ]
# Argument: moduleName - Optional. String. Only start debugging if debugging is enabled for ANY of the passed in modules.
# Example:     buildDebugStart || :
# Example:     # ... complex code here
# Example:     buildDebugStop || :. -
#
buildDebugStart() {
  if ! buildDebugEnabled "$@"; then
    return 1
  fi
  __buildDebugEnable
}

#
# Stop build debugging if it is enabled
# Usage: buildDebugStop
# See: buildDebugStart
#
buildDebugStop() {
  if ! buildDebugEnabled "$@"; then
    return 1
  fi
  __buildDebugDisable
}

#
# Returns whether the shell has the debugging flag set
#
# Useful if you need to temporarily enable or disable it.
#
isBashDebug() {
  case $- in *x*) return 0 ;; esac
  return 1
}

#
# Returns whether the shell has the error exit flag set
#
# Useful if you need to temporarily enable or disable it.
# Note that `set -e` is not inherited by shells so turning it
# on has little effect except on the current script running.
#
#     set -e
#     printf "$(isErrorExit; printf %d %?)"
#
# Outputs `1` always
#
isErrorExit() {
  case "$-" in *e*) return 0 ;; esac
  return 1
}

# Internal: true
# Utility function for debuggingStack
# See: debuggingStack
__debuggingStackCodeList() {
  local tick item index
  tick='`'
  index=0
  for item in "$@"; do
    printf -- '%d. %s%s%s\n' "$(($# - index))" "$tick" "$item" "$tick"
    index=$((index + 1))
  done
}

#
# Usage: {fn} [ -x ]
#
# Dump the function and include stacks and the current environment
# Argument: -x - Optional. Flag. Show exported variables. (verbose)
#
debuggingStack() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local prefix index next sources=() last showExports=false addMe=false

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      -x)
        showExports=true
        ;;
      --me)
        addMe=true
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  sources=()
  index=0
  next=1
  last=$((${#BASH_SOURCE[@]} - 1))
  if $addMe; then
    sources+=("${BASH_SOURCE[index]-}:$LINENO - ${FUNCNAME[0]}")
  fi
  while [ $index -lt $last ]; do
    sources+=("${BASH_SOURCE[next]-}:${BASH_LINENO[index]} - ${FUNCNAME[next]-}")
    index=$((index + 1))
    next=$((index + 1))
  done
  __debuggingStackCodeList "${sources[@]}" || :
  if $showExports; then
    printf "EXPORTS:\n"
    prefix="declare -x "
    declare -px | cut -c "$((${#prefix} + 1))-"
  fi
}

#
# Usage: plumber command ...
# Run command and detect any global or local leaks
#
plumber() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local __before __after __changed __ignore __pattern __command
  local __result=0
  local __ignore=(OLDPWD _ resultCode LINENO PWD BASH_COMMAND BASH_ARGC BASH_ARGV)

  # BASH_COMMAND for DEBUG
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --leak)
        shift
        __ignore+=("$(usageArgumentString "$usage" "globalName" "${1-}")") || return $?
        ;;
      *)
        break
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  [ $# -gt 0 ] || return 0
  isCallable "${1-}" || __failArgument "$usage" "$1 is not callable" "$@" || return $?

  __after=$(mktemp) || _environment mktemp || return $?
  __before="$__after.before"
  __after="$__after.after"

  declare -p >"$__before"
  if "$@"; then
    declare -p >"$__after"
    __pattern="$(quoteGrepPattern "^($(joinArguments '|' "${__ignore[@]}"))=")"
    __changed="$(diff "$__before" "$__after" | grep 'declare' | grep '=' | grep -v -e 'declare -[-a-z]*r ' | removeFields 3 | grep -v -e "$__pattern")" || :
    __command=$(consoleCode "$(_command "$@")")
    if grep -q -e 'COLUMNS\|LINES' < <(printf "%s\n" "$__changed"); then
      consoleWarning "$__command set $(consoleValue "COLUMNS, LINES")" 1>&2
      unset COLUMNS LINES
      __changed="$(printf "%s\n" "$__changed" | grep -v -e 'COLUMNS\|LINES' || :)" || _environment "Removing COLUMNS and LINES from $__changed" || return $?
    fi
    if [ -n "$__changed" ]; then
      printf "%s\n" "$__changed" | dumpPipe "$__command leaked local or export" 1>&2
      __result=$(_code leak)
    fi
  else
    __result=$?
  fi
  rm -rf "$__before" "$__after" || :
  return "$__result"
}
_plumber() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List files in paths with a checksum, sorted
_housekeeperAccountant() {
  local path
  for path in "$@"; do
    find "$path" -type f -print0 | xargs -0 shasum
  done | sort
}

# Run a command and ensure files are not modified
# Usage: {fn} [ --help ] [ --ignore grepPattern ] [ --path path ] [ path ... ] callable
# Argument: --path path - Optional. Directory. One or more directories to watch. If no directories are supplied uses current working directory.
housekeeper() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local watchPaths path
  local __before __after __changed __ignore __pattern __command
  local __result=0
  local __ignore=()

  watchPaths=()
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --ignore)
        shift
        __pattern="$(usageArgumentString "$usage" "grepPattern" "${1-}")" || return $?
        __ignore+=(-e "$__pattern")
        ;;
      --path)
        shift
        path="$(usageArgumentDirectory "$usage" "path" "${1-}")" || return $?
        watchPaths+=("$path")
        ;;
      *)
        if [ -d "$1" ]; then
          watchPaths+=("$1")
        else
          break
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  if [ "${#watchPaths[@]}" -eq 0 ]; then
    path=$(__usageEnvironment "$usage" pwd) || return $?
    watchPaths+=("$path")
  fi
  [ $# -gt 0 ] || return 0
  isCallable "${1-}" || __failArgument "$usage" "$1 is not callable" "$@" || return $?

  __after=$(mktemp) || _environment mktemp || return $?
  __before="$__after.before"
  __after="$__after.after"

  _housekeeperAccountant "${watchPaths[@]}" >"$__before"
  if "$@"; then
    _housekeeperAccountant "${watchPaths[@]}" >"$__after"
    if [ "${#__ignore[@]}" -gt 0 ]; then
      __changed="$(diff "$__before" "$__after" | grep -e '^[<>]' | grep -v "${__ignore[@]+${__ignore[@]}}" || :)"
    else
      __changed="$(diff "$__before" "$__after" | grep -e '^[<>]' || :)"
    fi
    __command=$(consoleCode "$(_command "$@")")
    if [ -n "$__changed" ]; then
      printf "%s\n" "$__changed" | dumpPipe "$__command modified files" 1>&2
      __result=$(_code leak)
    fi
  else
    __result=$?
  fi
  rm -rf "$__before" "$__after" || :
  return "$__result"
}
_housekeeper() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Check output for content and trigger environment error if found
# Usage {fn} [ --help ] [ --verbose ] [ --name name ]
# Argument: --help - Help
# Argument: --verbose - Optional. Flag. Verbose messages when no errors exist.
# Argument: --name name - Optional. String. Name for verbose mode.
# # shellcheck source=/dev/null
# Example:     source "$include" > >(outputTrigger source "$include") || return $?
outputTrigger() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local error message verbose name

  name="${FUNCNAME[1]}}"
  verbose=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verbose=true
        ;;
      --name)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        [ -n "$1" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        name="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $argument" || return $?
  done

  error=$(mktemp) || __failEnvironment "$usage" "mktemp" "$@" || return $?
  lineCount=0
  while read -r line; do
    printf "%s\n" "$line" >>"$error"
    lineCount=$((lineCount + 1))
  done
  lineText="$lineCount $(plural "$lineCount" line lines)"
  if [ ! -s "$error" ]; then
    rm -rf "$error" || :
    ! $verbose || consoleInfo "No output in $(consoleCode "$name") $(consoleValue "$lineText")" || :
    return 0
  fi
  message=$(dumpFile "$error") || message="dumpFile $error failed"
  rm -rf "$error" || :
  _environment "stderr found in $(consoleCode "$name") $(consoleValue "$lineText"): " "$@" "$message" || return $?
}
_outputTrigger() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_bashDebugHelp() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" "$@"
}

_bashDebugWatch() {
  if [ "${#BASH_DEBUG_WATCH[@]}" -gt 0 ]; then
    for __item in "${BASH_DEBUG_WATCH[@]}"; do
      if ! __value="$(eval "printf \"%s\n\" \"$__item\"" 2>/dev/null)"; then
        __value="$(consoleRed "unbound")"
      else
        __value="\"$(consoleCode "$__value")\""
      fi
      printf -- "WATCH %s: %s\n" "$__item" "$__value"
    done
  fi
}

__bashDebugStackDump() {
  local index="$1" __where
  export BUILD_HOME
  __where="$(realPath "${BASH_SOURCE[index]}")"
  __where="${__where#"$BUILD_HOME"}"
  printf "@ %s:%s %s()\n" "$(consoleBoldOrange "$__where")" "$(consoleBoldBlue "${BASH_LINENO[index + 1]}")" "$(consoleCode "${FUNCNAME[index]}")"
}

# Internal trap to capture DEBUG events and allow control
# See: bashDebug
_bashDebugTrap() {
  local __where __command __item __value __list __found
  export BUILD_HOME BASH_DEBUG_WATCH
  case "$BASH_COMMAND" in
    bashDebuggerDisable | "trap - DEBUG" | '"$@"') return 0 ;;
    *) ;;
  esac

  # Save Application FDs
  exec 30>&0 31>&1 32>&2
  # Restore Debugger FDs
  exec 0>&20 1>&21 2>&22

  __bashDebugStackDump 4
  __bashDebugStackDump 3
  __bashDebugStackDump 2
  __bashDebugStackDump 1
  __bashDebugStackDump 0

  _bashDebugWatch
  printf -- "%s %s\n" "$(consoleGreen ">")" "$(consoleCode "$BASH_COMMAND")"
  while read -r -e -p "bashDebug> " __command; do
    [ -n "$__command" ] || break
    case "$__command" in
      "\s")
        consoleWarning "Skipping $BASH_COMMAND"
        # Restore Application FDs
        exec 0>&30 1>&31 2>&32
        return 1
        ;;
      "?" | "help" | "\?")
        _bashDebug 0
        ;;
      "\u "*)
        __item="${__command:3}"
        __list=()
        __found=false
        for __value in "${BASH_DEBUG_WATCH[@]+"${BASH_DEBUG_WATCH[@]}"}"; do
          if [ "$__value" = "$__item" ]; then
            consoleBoldOrange "Removed $__item from watch list"
            __found=true
          else
            __list+=("$__value")
          fi
        done
        if ! $__found; then
          # shellcheck disable=SC2059
          printf -- "%s\n%s" "$(consoleError "No $__item found in watch list:")" "$(printf -- "- $(consoleCode %s)\n" "${__list[@]+"${__list[@]}"}")"
        fi
        BASH_DEBUG_WATCH=("${__list[@]+"${__list[@]}"}")
        _bashDebugWatch
        ;;
      "\w "*)
        __item="${__command:3}"
        consoleBoldOrange "Watching $__item"
        BASH_DEBUG_WATCH+=("$__item")
        _bashDebugWatch
        ;;
      "\q")
        trap - DEBUG
        # Restore Application FDs
        exec 0>&30 1>&31 2>&32
        return 0
        ;;
      *)
        printf "%s \"%s\"\n" "$(consoleWarning "Evaluating")" "$(consoleCode "$__command")" >/dev/stdout
        # Restore Application FDs
        exec 0>&30 1>&31 2>&32
        set +eu
        set +o pipefail
        eval "$__command" || printf "%s\n" "$(consoleError "EXIT $?")" 1>&2
        # Save Application FDs (may have changed)
        exec 30>&0 31>&1 32>&2
        # Restore Debugger FDs
        exec 0>&20 1>&21 2>&22
        ;;
    esac
  done
}

bashDebuggerEnable() {
  export BASH_DEBUG_WATCH
  BASH_DEBUG_WATCH=()
  # Save debugger FDs for later
  exec 20>&0 21>&1 22>&2
  set -o functrace
  shopt -s extdebug
  trap _bashDebugTrap DEBUG
}

bashDebuggerDisable() {
  trap - DEBUG
  shopt -u extdebug
  set +o functrace
  # Restore debugger FDs
  exec 0>&20 1>&21 2>&22
}

# Simple debugger to walk through a program
#
# Usage: {fn} commandToDebug ...
# Argument: commandToDebug - Callable. Required. Command to debug.
#
# Debugger accepts the following commands:
#
# `\s` - Skip next bash command
# `\h` - This help
# `\q` - Quit debugger (continue execution)
# `\w variable` - Evaluate this expression upon each debugger breakpoint
# `\u variable` - Unwatch a variable
#
# Any other command entered in the debugger is evaluated immediately.
#
bashDebug() {
  bashDebuggerEnable
  "$@"
  bashDebuggerDisable
}
_bashDebug() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}"
}
