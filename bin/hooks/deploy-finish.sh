#!/usr/bin/env bash
#
# Run during deployRemoteFinish
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# End of deployment to system, update local settings or register server before
# maintenance is turned off.
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # fn: {base}
  # Summary: Deployment "finish" script
  #
  # Return Code: 0 - This SHOULD exit successfully always
  #
  # Example: - Move directories to make deployment final
  __hookDeployFinish() {
    ! buildDebugEnabled || decorate success "${BASH_SOURCE[0]} is a noop and should be replaced or deleted." || :
    : "$@"
  }

  __hookDeployFinish "$@"
fi
