#!/usr/bin/env bash
#
# Run after tests are run to clean up the environment or artifacts from testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

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
# Runs after tests have been run to clean up any artifacts or other test files which
# may have been generated.
#
# fn: {base}
__hookTestCleanup() {
  ! buildDebugEnabled || consoleSuccess "Test cleanup does nothing - please rewrite"
}

__tools ../.. __hookTestCleanup "$@"
