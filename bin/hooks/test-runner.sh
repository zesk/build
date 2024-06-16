#!/usr/bin/env bash
#
# Runs our tests on the built environment
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

__loader __hookTestRunner "$@"
