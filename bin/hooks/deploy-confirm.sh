#!/usr/bin/env bash
#
# Run during bin/build/pipeline/php-deploy.sh
#
# Run in the pipeline, used to check smoke test on remote systems: did our deployment work?
#
# If not, fail and it will undo it.
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
# Summary: Deployment confirmation script
#
# Exit code: 0 - Continue with deployment
# Exit code: Non-zero - Any non-zero exit code will run `deploy-revert` hook on all systems and cancel deployment
# should do wahtever is required to ensure that.
#
# Example: - Enable a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
# Example: - Check the home page for a version number
# Example: - Check for a known artifact (build sha) in the server somehow
# Example: - etc.
__hookDeployConfirm() {
  ! buildDebugEnabled || consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced with live smoke tests"
}

__loader __hookDeployConfirm
