#!/usr/bin/env bash
#
# Run before tests are run and before environment is built for testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __loader 11
set -eou pipefail
# Load zesk build and run command
__loader() {
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
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

__loader __hookTestSetup "$@"
