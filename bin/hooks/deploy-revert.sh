#!/usr/bin/env bash
#
# Run during deployRemoteFinish
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Do any steps after a deployment fails to undo and restore the previous deployment on a host
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # After a deployment was successful on a host, this reverts that deployment and goes back to the previous version.
  #
  # fn: {base}
  # Summary: Deployment "undo" script
  #
  # Return Code: 0 - This SHOULD exit successfully always
  __hookDeployRevert() {
    ! buildDebugEnabled || decorate success "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
  }

  __hookDeployRevert "$@"
fi
