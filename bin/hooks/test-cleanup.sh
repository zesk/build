#!/usr/bin/env bash
#
# Run after tests are run to clean up the environment or artifacts from testing
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
# Runs after tests have been run to clean up any artifacts or other test files which
# may have been generated.
#
# fn: {base}
__hookTestCleanup() {
  ! buildDebugEnabled || consoleSuccess "Test cleanup does nothing - please rewrite"
}

__loader __hookTestCleanup "$@"
