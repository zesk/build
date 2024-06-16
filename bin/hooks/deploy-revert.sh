#!/usr/bin/env bash
#
# Run during bin/build/pipeline/deploy-remote-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Do any steps after a deployment fails to undo and restore the previous deployment on a host
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

# After a deployment was successful on a host, this undos that deployment and goes back to the previous version.
#
# fn: {base}
# Summary: Deployment "undo" script
#
# Exit code: 0 - This SHOULD exit successfully always
__hookDeployRevert() {
  ! buildDebugEnabled || consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
}

__hookDeployRevert "$@"
