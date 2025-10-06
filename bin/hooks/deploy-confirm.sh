#!/usr/bin/env bash
#
# Run during deployApplication
#
# Run in the pipeline, used to check smoke test on remote systems: did our deployment work?
#
# If not, fail and it will undo it.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # fn: {base}
  # Summary: Deployment confirmation script
  #
  # Return Code: 0 - Continue with deployment
  # Return Code: Non-zero - Any non-zero exit code will run `deploy-revert` hook on all systems and cancel deployment
  # should do wahtever is required to ensure that.
  #
  # Example: - Enable a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
  # Example: - Check the home page for a version number
  # Example: - Check for a known artifact (build sha) in the server somehow
  # Example: - etc.
  __hookDeployConfirm() {
    ! buildDebugEnabled || decorate success "${BASH_SOURCE[0]} is a noop and should be replaced with live smoke tests"
  }

  __hookDeployConfirm "$@"
fi
