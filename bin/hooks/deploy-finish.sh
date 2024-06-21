#!/usr/bin/env bash
#
# Run during bin/build/pipeline/deploy-remote-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# End of deployment to system, update local settings or register server before
# maintenance is turned off.
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
# Summary: Deployment "finish" script
#
# Exit code: 0 - This SHOULD exit successfully always
#
# Example: - Move directories to make deployment final
__hookDeployFinish() {
  ! buildDebugEnabled || consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted." || :
  : "$@"
}

__loader __hookDeployFinish "$@"
