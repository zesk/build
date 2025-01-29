#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
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
# Environment: BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. `BUILD_DEBUG` may be a comma-separated list of modules to target debugging.
# Example:     BUILD_DEBUG=false # All debugging disabled
# Example:     BUILD_DEBUG= # All debugging disabled
# Example:     BUILD_DEBUG=usage,documentation # Debug usage and documentation calls
# Requires: -
buildDebugEnabled() {
  # NOTE: This allows runtime changing of this value
  export BUILD_DEBUG

  # DO NOT buildEnvironmentLoad BUILD_DEBUG - infinite loops
  local debugString
  debugString="${BUILD_DEBUG-}"
  # BUILD_DEBUG=false - All debugging disabled
  # BUILD_DEBUG= - All debugging disabled
  if [ -z "$debugString" ] || [ "$debugString" = "false" ]; then
    return 1
  fi
  # BUILD_DEBUG is non-blank and does not equal `false`
  # `true` means debugging ALWAYS enabled
  # No arguments (no test) means debugging enabled (as long as something is enabled)
  if [ "$debugString" = "true" ] || [ $# -eq 0 ]; then return 0; fi
  # Convert to list
  debugString=",$debugString,"
  while [ $# -gt 0 ]; do
    # If any token found in the list, debugging is enabled
    if [ "${debugString/,$1,/}" != "${debugString}" ]; then return 0; fi
    shift
  done
  # Debugging is not enabled
  return 1
}

# Internal: true
# Usage: {fn} [ setArgs ]
# Turn on debugging and additional `set` arguments
# Actually does 'set -x` - should be only occurrence.
# Depends: -
__buildDebugEnable() {
  set "-x${1-}" # Debugging
}

# Usage: {fn} [ setArgs ]
# Turn off debugging and additional `set` arguments
# Internal: true
# Depends: -
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
# Requires: buildDebugEnabled
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
# Requires: buildDebugEnabled
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
# Depends: -
isBashDebug() {
  case $- in *x*) return 0 ;; esac
  return 1
}

# Place this in code where you suspect an infinite loop occurs
# It will fail upon a second call; to reset call with `--end`
# Argument: --end - Flag. Optional. Stop testing for recursion.
# When called twice, fails on the second invocation and dumps a call stack to stderr.
# Requires: printf unset  export debuggingStack exit
# Environment: __BUILD_RECURSION
bashRecursionDebug() {
  export __BUILD_RECURSION

  if [ "${__BUILD_RECURSION-}" = "true" ]; then
    if [ "${1-}" = "--end" ]; then
      unset __BUILD_RECURSION
      return 0
    fi
    printf "%s%s\n" "RECURSION FAILURE" "$(debuggingStack)" 1>&2
    exit 91
  fi
  if [ "${1-}" = "--end" ]; then
    printf "%s%s\n" "RECURSION FAILURE (end without start)" "$(debuggingStack)" 1>&2
    exit 91
  fi

  __BUILD_RECURSION=true
}

# Adds a trap to capture the debugging stack on interrupt
# Use this in a bash script which runs forever or runs in an infinite loop to
# determine where the problem or loop exists.
# Requires: trap
# Argument: --help
bashDebugInterruptFile() {
  local usage="_${FUNCNAME[0]}" name="__bashDebugInterruptFile" traps
  __help "$usage" --only "$@" || return 0
  traps=$(fileTemporaryName "$usage")
  trap >"$traps" || _clean "$?" "$traps" || __throwEnvironment "trap failed" || return $?
  if grep "$name" "$traps" | grep -q " SIGINT"; then
    __throwEnvironment "$usage" "Already installed" || _clean "$?" "$traps" || return $?
  fi
  __catchEnvironment "$usage" rm -rf "$traps" || return $?
  __catchEnvironment "$usage" trap __bashDebugInterruptFile INT || return $?
}
_bashDebugInterruptFile() {
  ! false || bashDebugInterruptFile --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__bashDebugInterruptFile() {
  export BUILD_HOME

  trap - INT
  debuggingStack >"$BUILD_HOME/.interrupt" || :
  exit 99
}

#
# Returns whether the shell has the error exit flag set
#
# Useful if you need to temporarily enable or disable it.
#
# October 2024 - Does appear to be inherited by subshells
#
#     set -e
#     printf "$(isErrorExit; printf %d $?)"
#
# Outputs `1` always
# Requires: -
isErrorExit() {
  # printf "isErrorExit: %s\n" "$-" 1>&2
  case "$-" in *e* | *E*) return 0 ;; esac
  return 1
}

# Internal: true
# Utility function for debuggingStack
# See: debuggingStack
# Requires: printf
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
# Requires: printf usageDocument
debuggingStack() {
  local usage="_${FUNCNAME[0]}"

  local prefix index next sources=() last showExports=false addMe=false

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
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
_debuggingStack() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  ! true || debuggingStack --help
}

#
# Usage: plumber command ...
# Run command and detect any global or local leaks
# Requires: declare diff grep
# Requires: __throwArgument decorate usageArgumentString isCallable
# Requires: fileTemporaryName removeFields
plumber() {
  local usage="_${FUNCNAME[0]}"

  local __before __after __changed __ignore __pattern __cmd
  local __result=0
  local __ignore=(OLDPWD _ resultCode LINENO PWD BASH_COMMAND BASH_ARGC BASH_ARGV BUILD_DEBUG)

  # BASH_COMMAND for DEBUG
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ $# -gt 0 ] || return 0
  isCallable "${1-}" || __throwArgument "$usage" "$1 is not callable" "$@" || return $?

  __after=$(fileTemporaryName "$usage") || return $?
  __before="$__after.before"
  __after="$__after.after"

  declare -p >"$__before"
  if "$@"; then
    declare -p >"$__after"
    __pattern="$(quoteGrepPattern "^($(joinArguments '|' "${__ignore[@]}"))=")"
    __changed="$(diff "$__before" "$__after" | grep -e '^declare' | grep '=' | grep -v -e 'declare -[-a-z]*r ' | removeFields 2 | grep -v -e "$__pattern")" || :
    __cmd="$(decorate each code "$@")"
    if grep -q -e 'COLUMNS\|LINES' < <(printf "%s\n" "$__changed"); then
      decorate warning "$__cmd set $(decorate value "COLUMNS, LINES")" 1>&2
      unset COLUMNS LINES
      __changed="$(printf "%s\n" "$__changed" | grep -v -e 'COLUMNS\|LINES' || :)" || _environment "Removing COLUMNS and LINES from $__changed" || return $?
    fi
    if [ -n "$__changed" ]; then
      printf "%s\n" "$__changed" | dumpPipe "$(decorate bold-orange "found leak"): $__cmd" 1>&2
      __result=$(_code leak)
    fi
  else
    __result=$?
  fi
  rm -rf "$__before" "$__after" || :
  return "$__result"
}
_plumber() {
  # _IDENTICAL_ usageDocument 1
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

  local watchPaths path
  local __before __after __changed __ignore __pattern __cmd
  local __result=0
  local __ignore=()

  watchPaths=()
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if [ "${#watchPaths[@]}" -eq 0 ]; then
    path=$(__catchEnvironment "$usage" pwd) || return $?
    watchPaths+=("$path")
  fi
  [ $# -gt 0 ] || return 0
  isCallable "${1-}" || __throwArgument "$usage" "$1 is not callable" "$@" || return $?

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
    __cmd=$(decorate each code "$@")
    if [ -n "$__changed" ]; then
      printf "%s\n" "$__changed" | dumpPipe "$__cmd modified files" 1>&2
      __result=$(_code leak)
    fi
  else
    __result=$?
  fi
  rm -rf "$__before" "$__after" || :
  return "$__result"
}
_housekeeper() {
  # _IDENTICAL_ usageDocument 1
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
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verbose=true
        ;;
      --name)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        [ -n "$1" ] || __throwArgument "$usage" "Blank $argument argument" || return $?
        name="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || __throwArgument "$usage" "shift argument $argument" || return $?
  done

  error=$(mktemp) || __throwEnvironment "$usage" "mktemp" "$@" || return $?
  lineCount=0
  while read -r line; do
    printf "%s\n" "$line" >>"$error"
    lineCount=$((lineCount + 1))
  done
  lineText="$lineCount $(plural "$lineCount" line lines)"
  if [ ! -s "$error" ]; then
    rm -rf "$error" || :
    ! $verbose || decorate info "No output in $(decorate code "$name") $(decorate value "$lineText")" || :
    return 0
  fi
  message=$(dumpFile "$error") || message="dumpFile $error failed"
  rm -rf "$error" || :
  _environment "stderr found in $(decorate code "$name") $(decorate value "$lineText"): " "$@" "$message" || return $?
}
_outputTrigger() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
