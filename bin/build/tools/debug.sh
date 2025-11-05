#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: set test
# Docs: o ./documentation/source/tools/debug.md
# Test: o ./test/tools/debug-tests.sh

#
# Is build debugging enabled?
#
# Usage: {fn} [ moduleName ... ]
# Argument: moduleName - Optional. String. If `BUILD_DEBUG` contains any token passed, debugging is enabled.
# Return Code: 1 - Debugging is not enabled (for any module)
# Return Code: 0 - Debugging is enabled
# Environment: BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. `BUILD_DEBUG` may be a comma-separated list of modules to target debugging.
# Example:     BUILD_DEBUG=false # All debugging disabled
# Example:     BUILD_DEBUG= # All debugging disabled
# Example:     BUILD_DEBUG=usage,documentation # Debug usage and documentation calls
# Requires: -
buildDebugEnabled() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

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
_buildDebugEnabled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# For __buildDebugEnable
# Debugging: 513a78fb762a9632315fc564b560d644fd280f89
# Debugging: f6bef8d783239932a1b4311d027289c42d9d4b3f

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

# For buildDebugStart
# Debugging: c14d97f2fca824204ca0df151f444f4a7f08f556

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
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if ! buildDebugEnabled "$@"; then
    return 1
  fi
  __buildDebugEnable
}
_buildDebugStart() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Stop build debugging if it is enabled
# Usage: buildDebugStop
# See: buildDebugStart
# Requires: buildDebugEnabled
buildDebugStop() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  if ! buildDebugEnabled "$@"; then
    return 1
  fi
  __buildDebugDisable
}
_buildDebugStop() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Returns whether the shell has the debugging flag set
#
# Useful if you need to temporarily enable or disable it.
# Depends: -
isBashDebug() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  case $- in *x*) return 0 ;; esac
  return 1
}
_isBashDebug() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Place this in code where you suspect an infinite loop occurs
# It will fail upon a second call; to reset call with `--end`
# Argument: --end - Flag. Optional. Stop testing for recursion.
# When called twice, fails on the second invocation and dumps a call stack to stderr.
# Requires: printf unset  export debuggingStack exit
# Environment: __BUILD_RECURSION
bashRecursionDebug() {
  local handler="_${FUNCNAME[0]}"

  export __BUILD_RECURSION

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local cacheFile

  cacheFile="$(catchReturn "$handler" buildCacheDirectory)/.${FUNCNAME[0]}" || return $?
  if [ "${__BUILD_RECURSION-}" = "true" ]; then
    if [ "${1-}" = "--end" ]; then
      unset __BUILD_RECURSION
      catchEnvironment "$handler" rm -f "$cacheFile" || return $?
      return 0
    fi
    printf "%s\n" "RECURSION FAILURE" "$(debuggingStack)" "" "INITIAL CALL" "$(decorate code <"$cacheFile")" 1>&2
    catchEnvironment "$handler" rm -f "$cacheFile" || return $?
    exit 91
  fi
  if [ "${1-}" = "--end" ]; then
    printf "%s\n" "RECURSION FAILURE (end without start)" "$(debuggingStack)" 1>&2
    catchEnvironment "$handler" rm -f "$cacheFile" || return $?
    exit 91
  fi

  __BUILD_RECURSION=true
  catchEnvironment "$handler" debuggingStack >"$cacheFile" || return $?
}
_bashRecursionDebug() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Adds a trap to capture the debugging stack on interrupt
# Use this in a bash script which runs forever or runs in an infinite loop to
# determine where the problem or loop exists.
# Requires: trap
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --error - Flag. Add ERR trap.
# Argument: --interrupt - Flag. Add INT trap.
bashDebugInterruptFile() {
  local handler="_${FUNCNAME[0]}"
  local name="__bashDebugInterruptFile" traps=() clearFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --clear) clearFlag=true ;;
    --interrupt)
      inArray INT "${traps[@]+"${traps[@]}"}" || traps+=("INT")
      ;;
    --error)
      inArray ERR "${traps[@]+"${traps[@]}"}" || traps+=("ERR")
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  [ "${#traps[@]}" -gt 0 ] || traps+=("INT")

  if $clearFlag; then
    catchEnvironment "$handler" trap - "${traps[@]}" || return $?
    return 0
  fi
  local currentTraps installed=()
  currentTraps=$(fileTemporaryName "$handler") || return $?
  trap >"$currentTraps" || returnClean "$?" "$currentTraps" || throwEnvironment "trap listing failed" || return $?
  for trap in "${traps[@]}"; do
    if grep "$name" "$currentTraps" | grep -q " SIG${trap}"; then
      installed+=("$trap")
    fi
  done
  if [ "${#installed[@]}" -eq "${#traps[@]}" ]; then
    throwEnvironment "$handler" "Already installed" || returnClean $? "$currentTraps" || return $?
  fi
  catchEnvironment "$handler" rm -rf "$currentTraps" || return $?
  catchEnvironment "$handler" trap __bashDebugInterruptFile "${traps[@]}" || return $?
}
_bashDebugInterruptFile() {
  ! false || bashDebugInterruptFile --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__bashDebugInterruptFile() {
  export BUILD_HOME BASH_LINENO BASH_SOURCE BASH_ARGC BASH_ARGV FUNCNAME
  {
    local now
    now=$(date)
    printf "%s\n" "--- $BUILD_HOME terminated $now ------------------------------------------"
    debuggingStack -x --me
    printf "%s\n" "END --- $BUILD_HOME terminated $now ------------------------------------------" ""
  } >>"$BUILD_HOME/.interrupt.log" || :
  return 122
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
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # printf "isErrorExit: %s\n" "$-" 1>&2
  case "$-" in *e* | *E*) return 0 ;; esac
  return 1
}
_isErrorExit() {
  ! false || isErrorExit --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: plumber command ...
# Run command and detect any global or local leaks
# Requires: declare diff grep
# Requires: throwArgument decorate usageArgumentString isCallable
# Requires: fileTemporaryName removeFields
# BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after
plumber() {
  local handler="_${FUNCNAME[0]}"

  export TMPDIR

  local __before __after __changed __ignore __pattern __cmd __tempDir=$TMPDIR
  local __result=0
  local __ignore=(OLDPWD _ resultCode LINENO PWD BASH_COMMAND BASH_ARGC BASH_ARGV BUILD_DEBUG)
  local __verboseFlag=false
  # BASH_COMMAND for DEBUG
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --temporary) shift && __tempDir=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $? ;;
    --leak) shift && __ignore+=("$(usageArgumentString "$handler" "globalName" "${1-}")") || return $? ;;
    --verbose) __verboseFlag=true ;;
    *) break ;;
    esac
    shift
  done

  [ $# -gt 0 ] || return 0
  isCallable "${1-}" || throwArgument "$handler" "$1 is not callable" "$@" || return $?

  __after=$(TMPDIR=$__tempDir fileTemporaryName "$handler") || return $?
  __before="$__after.before"

  declare -p >"$__before"
  ! $__verboseFlag || dumpPipe "BEFORE" <"$__before"
  if "$@"; then
    local __rawChanged
    declare -p >"$__after"
    ! $__verboseFlag || dumpPipe "AFTER $__before $__after" <"$__after"
    __pattern="$(quoteGrepPattern "^\($(listJoin '|' "${__ignore[@]+"${__ignore[@]}"}")\)=")"
    __changed="$(diff -U0 "$__before" "$__after" | grep -e '^[-+][^-+]' | cut -c 2- | grep -e '^declare' | grep '=' | grep -v -e '^declare -[-a-z]*r ' | removeFields 2 | grep -v -e "$__pattern" || :)"
    __rawChanged=$__changed
    __cmd="$(decorate each code "$@")"
    if grep -q -e 'COLUMNS\|LINES' < <(printf "%s\n" "$__changed"); then
      # decorate warning "$__cmd set $(decorate value "COLUMNS, LINES")"
      unset COLUMNS LINES
      __changed="$(printf "%s\n" "$__changed" | grep -v -e 'COLUMNS\|LINES' || :)" || throwEnvironment "$handler" "Removing COLUMNS and LINES from $__changed" || return $?
    fi
    if [ -n "$__changed" ]; then
      printf "%s\n" "$__changed" "COMMAND: $__cmd" | dumpPipe "$(decorate bold-orange "found leak"): $__rawChanged" 1>&2
      if buildDebugEnabled plumber-verbose; then
        dumpPipe BEFORE <"$__before"
        dumpPipe AFTER <"$__after"
      fi
      __result=$(returnCode leak)
    fi
  else
    __result=$?
  fi
  catchEnvironment "$handler" rm -f "$__before" "$__after" || return $?
  return "$__result"
}
_plumber() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List files in paths with a checksum, sorted
# Use cacheDirectory if specified
_housekeeperAccountant() {
  local path cacheDirectory
  cacheDirectory="$1" && shift
  for path in "$@"; do
    if [ -d "$cacheDirectory" ]; then
      local saved
      saved=$(shaPipe <<<"$path")
      if [ -f "$cacheDirectory/$saved" ]; then
        cat "$cacheDirectory/$saved"
      else
        find "$path" -type f -print0 | xargs -0 sha1sum | tee "$cacheDirectory/$saved"
      fi
    else
      find "$path" -type f -print0 | xargs -0 sha1sum
    fi
  done | sort
}

# Run a command and ensure files are not modified
# Usage: {fn} [ --help ] [ --ignore grepPattern ] [ --path path ] [ path ... ] callable
# Argument: --path path - Optional. Directory. One or more directories to watch. If no directories are supplied uses current working directory.
housekeeper() {
  local handler="_${FUNCNAME[0]}"

  export TMPDIR

  local watchPaths path
  local __before __after __changed __ignore __pattern __cmd __tempDir=$TMPDIR
  local __result=0 overheadFlag=false __cacheDirectory=""
  local __ignore=()

  watchPaths=()
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --temporary) shift && __tempDir=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $? ;;
    --ignore)
      shift
      __pattern="$(usageArgumentString "$handler" "grepPattern" "${1-}")" || return $?
      __ignore+=(-e "$__pattern")
      ;;
    --cache) shift && __cacheDirectory=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $? ;;
    --overhead) overheadFlag=true ;;
    --path)
      shift
      path="$(usageArgumentDirectory "$handler" "path" "${1-}")" || return $?
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
    shift
  done

  if [ "${#watchPaths[@]}" -eq 0 ]; then
    path=$(catchEnvironment "$handler" pwd) || return $?
    watchPaths+=("$path")
  fi
  [ $# -gt 0 ] || return 0
  isCallable "${1-}" || throwArgument "$handler" "$1 is not callable" "$@" || return $?

  __after=$(TMPDIR="$__tempDir" fileTemporaryName "$handler") || return $?
  __before="$__after.before"
  local start testStart testEnd
  start=$(timingStart)
  # Cache the before but NOT the after
  _housekeeperAccountant "$__cacheDirectory" "${watchPaths[@]}" >"$__before"
  testStart=$(timingStart)
  if "$@"; then
    testEnd=$(timingStart)
    _housekeeperAccountant "" "${watchPaths[@]}" >"$__after"
    if [ "${#__ignore[@]}" -gt 0 ]; then
      __changed="$(diff "$__before" "$__after" | grep -e '^[<>]' | grep -v "${__ignore[@]+${__ignore[@]}}" || :)"
    else
      __changed="$(diff "$__before" "$__after" | grep -e '^[<>]' || :)"
    fi
    __cmd=$(decorate each code "$@")
    if [ -n "$__changed" ]; then
      printf "%s\n" "$(decorate code "$__cmd") modified files:" "$(printf "%s\n" "$__changed" | decorate wrap "- ")" "Watching:" "$(printf "%s\n" "${watchPaths[@]}" | decorate wrap "- ")" 1>&2
      __result=$(returnCode leak)
    fi
  else
    __result=$?
  fi
  rm -rf "$__before" "$__after" || :
  if $overheadFlag; then
    local end overhead
    end=$(timingStart)
    overhead=$((end - start - (testEnd - testStart)))
    printf -- "housekeeper overhead: %s\n" "$(timingFormat "$overhead")"
  fi
  return "$__result"
}
_housekeeper() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  local name="${FUNCNAME[1]}}" verbose=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verbose=true
      ;;
    --name)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      [ -n "$1" ] || throwArgument "$handler" "Blank $argument argument" || return $?
      name="$1"
      ;;
    *)
      break
      ;;
    esac
    shift
  done

  local error lineCount=0

  error=$(fileTemporaryName "$handler") || return $?
  local line
  while read -r line; do
    printf "%s\n" "$line" >>"$error"
    lineCount=$((lineCount + 1))
  done

  local lineText
  lineText="$(pluralWord "$lineCount" line)"
  if [ ! -s "$error" ]; then
    rm -rf "$error" || :
    ! $verbose || decorate info "No output in $(decorate code "$name") $(decorate value "$lineText")" || :
    return 0
  fi

  local message
  message=$(catchEnvironment "$handler" dumpPipe --vanish "$error") || return $?
  throwEnvironment "$handler" "stderr found in $(decorate code "$name") $(decorate value "$lineText"): " "$@" "$message" || return $?
}
_outputTrigger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__filesOpenList() {
  lsof -a -d 0-2147483647 -p "$1"
}

__processChildrenIDs() {
  pgrep -P "$1"
}

# Output current open files
# stdout
debugOpenFiles() {
  local handler="_${FUNCNAME[0]}"

  local name="${FUNCNAME[1]}}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    esac
    shift
  done

  muzzle packageWhich lsof || return $?

  printf "%s\n" "PID: $$"
  __filesOpenList "$$"
  local child children=()

  read -r -a children < <(__processChildrenIDs "$$") || :
  for child in "${children[@]+"${children[@]}"}"; do
    printf "%s\n" "Child PID: $child"
    __filesOpenList "$child"
  done
}
_debugOpenFiles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
