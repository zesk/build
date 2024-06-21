#!/usr/bin/env bash
#
# Run during bin/build/pipeline/deploy-remote-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Start of deployment to system, delete caches and deal with post-maintenance stopping of services, etc.
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

# Deployment "start" script
#
# fn: {base}
# Exit code: 0 - This SHOULD exit successfully always
# Example: - Move directories to make deployment final
__hookDeployStart() {
  ! buildDebugEnabled || cconsoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
  : "$@"
}

__loader __hookDeployStart "$@"
