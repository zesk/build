#!/usr/bin/env bash
#
# Run during deployRemoteFinish
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Start of deployment to system, delete caches and deal with post-maintenance stopping of services, etc.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then
  # fn: {base}
  #
  # This is called where the current working directory at the time of
  # running is the **new** application and the `applicationPath` which is
  # passed as an argument is the place where the **new** application should be moved to
  # in order to activate it.
  #
  # Summary: Deployment move script
  # Usage: hookRun deploy-activate applicationPath
  # Argument: applicationPath - This is the target for the current application
  # Return Code: 0 - This is called to replace the running application in-place
  #
  __hookDeployMove() {
    ! buildDebugEnabled || decorate success "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
  }

  __hookDeployMove "$@"
fi
