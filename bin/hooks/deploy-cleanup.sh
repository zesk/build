#!/usr/bin/env bash
#
# Run during deployRemoteFinish
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Delete any temporary files left over from deployment and finish deployment.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # fn: {base}
  # Summary: Run after a successful deployment
  # Run on remote systems after deployment has succeeded on all systems.
  #
  # This step must always succeed on the remote system; the deployment step prior to this
  # should do whatever is required to ensure that.
  #
  __hookDeployCleanup() {
    ! buildDebugEnabled || decorate success "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
    : "$@"
  }
  __hookDeployCleanup "$@"
fi
