#!/usr/bin/env bash
#
# Run before tests are run and before environment is built for testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
}

# IDENTICAL __tools 12
# Load tools.sh and run command
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

#
# Sets up our environment for our tests. May build a test image, set up a test database, start a test version of the
# system, or deploy to a test environment for testing.
#
# The default hook does nothing and exits successfully.
#
# Exit Code: 0 - If the test setup was successful
# Exit Code: Non-Zero - Any error will terminate testing
#
# fn: {base}
__hookTestSetup() {
  ! buildDebugEnabled || consoleSuccess "Test setup does nothing - please rewrite"
}

__tools ../.. __hookTestSetup "$@"
