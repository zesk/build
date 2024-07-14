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
  __environment buildEnvironmentLoad BUILD_DEBUG || return $?
  debugString="${BUILD_DEBUG-}"
  if test "$debugString"; then
    [ $# -eq 0 ] && return 0
    debugString=",$debugString,"
    while [ $# -gt 0 ]; do
      [ "${debugString/,$1,/}" != "${debugString}" ] && return 0
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
  fi
}

#
# Stop build debugging if it is enabled
# Usage: buildDebugStop
# See: buildDebugStart
#
buildDebugStop() {
  if buildDebugEnabled "$@"; then
    set +x # Debugging off
  fi
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
  # consoleBoldRed "isErrorExit $- ::" 1>&2
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
  local __before __after __changed __ignore __pattern __command
  local __result=0
  local __ignore=(OLDPWD _ resultCode LINENO PWD)

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
