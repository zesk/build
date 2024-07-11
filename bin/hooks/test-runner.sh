#!/usr/bin/env bash
#
# Runs our tests on the built environment
#
# Copyright &copy; 2024 Market Acumen, Inc.
#



# IDENTICAL __tools 13
# Usage: __tools command ...
# Load zesk build and run command
__tools() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/tools.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
}

# Runs our tests; any non-zero exit code is considered a failure and will terminate
# deployment steps.
#
# The default hook for this fails with exit code 99 by default.
# Exit Code: 0 - If the tests all pass
# Exit Code: Non-Zero - If any test fails for any reason
#
# fn: {base}
__hookTestRunner() {
  ! buildDebugEnabled || consoleError "Test runner does nothing, failing, rewrite this."
  return 99
}

__tools ../.. __hookTestRunner "$@"
