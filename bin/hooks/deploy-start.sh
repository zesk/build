#!/usr/bin/env bash
#
# Run during deployRemoteFinish
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Start of deployment to system, delete caches and deal with post-maintenance stopping of services, etc.
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # Deployment "start" script
  #
  # fn: {base}
  # Return Code: 0 - This SHOULD exit successfully always
  # Example: - Move directories to make deployment final
  __hookDeployStart() {
    ! buildDebugEnabled || cdecorate success "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
    : "$@"
  }

  __hookDeployStart "$@"
fi
