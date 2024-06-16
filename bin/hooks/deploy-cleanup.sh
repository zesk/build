#!/usr/bin/env bash
#
# Run during bin/build/pipeline/deploy-remote-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Delete any temporary files left over from deployment and finish deployment.
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
# fn: {base}
# Summary: Run after a successful deployment
# Run on remote systems after deployment has succeeded on all systems.
#
# This step must always succeed on the remote system; the deployment step prior to this
# should do whatever is required to ensure that.
#
__hookDeployCleanup() {
  ! buildDebugEnabled || consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
  : "$@"
}

__loader __hookDeployCleanup "$@"
