#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: -
# bin: set test
# Docs: o ./docs/_templates/tools/debug.md
# Test: o ./test/tools/debug-tests.sh

#
# Is build debugging enabled?
#
# Usage: buildDebugEnabled
# Exit Code: 1 - Debugging is not enabled
# Exit Code: 0 - Debugging is enabled
# Environment: BUILD_DEBUG - Set to 1 to enable debugging, blank to disable
#
buildDebugEnabled() {
  # shellcheck source=/dev/null
  if ! source bin/build/env/BUILD_DEBUG.sh; then
    consoleError "BUILD_DEBUG.sh failed" 1>&2
    return 1
  fi
  export BUILD_DEBUG

  test "${BUILD_DEBUG-}"
}

#
# Start build debugging if it is enabled.
# This does `set -x` which traces and outputs every shell command
# Use it to debug when you can not figure out what is happening internally.
#
# Usage: buildDebugStart
# Example:     buildDebugStart
# Example:     # ... complex code here
# Example:     buildDebugStop
#
buildDebugStart() {
  if buildDebugEnabled; then
    set -x # Outputs each command for debugging
  fi
}

#
# Stop build debugging if it is enabled
# Usage: buildDebugStop
# See: buildDebugStart
#
buildDebugStop() {
  if buildDebugEnabled; then
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
