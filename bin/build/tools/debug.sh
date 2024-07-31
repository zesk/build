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

#
# Start build debugging if it is enabled.
# This does `set -x` which traces and outputs every shell command
# Use it to debug when you can not figure out what is happening internally.
#
# Usage: {fn} [ moduleName ... ]
# Argument: moduleName - Optional. String. Only start debugging if debugging is enabled for ANY of the passed in modules.
# Example:     buildDebugStart
# Example:     # ... complex code here
# Example:     buildDebugStop
#
buildDebugStart() {
  if buildDebugEnabled "$@"; then
    set -x # Outputs each command for debugging
    return 0
  fi
  return 1
}

#
# Stop build debugging if it is enabled
# Usage: buildDebugStop
# See: buildDebugStart
#
buildDebugStop() {
  if buildDebugEnabled "$@"; then
    set +x # Debugging off
    return 0
  fi
  return 1
}

#
# Returns whether the shell has the debugging flag set
#
# Useful if you need to temporarily enable or disable it.
#
# Usage: {fn}
#
isBashDebug() {
  case $- in *x*) return 0 ;; esac
  return 1
}

#
# Returns whether the shell has the error exit flag set
#
# Useful if you need to temporarily enable or disable it.
# Note that `set -e` is not inherited by shells so
#
#     set -e
#     printf "$(isErrorExit; printf %d %?)"
#
# Outputs `1` always
#
# Usage: {fn}
#
isErrorExit() {
  case "$-" in *e*) return 0 ;; esac
  return 1
}

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
# Usage: {fn} [ -s ]
#
# Dump the function and include stacks and the current environment
#
debuggingStack() {
  local prefix
  printf "STACK:\n"
  __debuggingStackCodeList "${FUNCNAME[@]}" || :00
  printf "SOURCE:\n"
  __debuggingStackCodeList "${BASH_SOURCE[@]}" || :
  if [ "${1-}" != "-s" ]; then
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
  local __ignore=(OLDPWD _ resultCode LINENO PWD)

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
      printf "%s\n" "$__changed" | dumpPipe "$__command leaked local or export ($__before -> $__after)" 1>&2
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
