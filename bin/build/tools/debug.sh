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
  case $- in
    *x*)
      return 0
      ;;
  esac
  return 1
}

#
# Returns whether the shell has the error exit flag set
#
# Useful if you need to temporarily enable or disable it.
#
# Usage: {fn}
#
isErrorExit() {
  case $- in
    *e*)
      return 0
      ;;
  esac
  return 1
}

#
# Usage: {fn}
# Example:     save=$(saveErrorExit)
# Example:     set +x
# Example:     ... some nasty stuff
# Example:     restoreErrorExit "$save"
# See: restoreErrorExit
saveErrorExit() {
  if isErrorExit; then
    printf %d 1
  fi
}

# Usage: {fn}
# Example:     save=$(saveErrorExit)
# Example:     set +x
# Example:     ... some nasty stuff
# Example:     restoreErrorExit "$save"
# See: saveErrorExit
restoreErrorExit() {
  if [ "$1" = "1" ]; then
    set -e
  else
    set +e
  fi
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
