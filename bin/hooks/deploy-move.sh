#!/usr/bin/env bash
#
# Run during bin/build/pipeline/report-deploy-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Start of deployment to system, delete caches and deal with post-maintenance stopping of services, etc.
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# fn: {base}
#
# This is called where the current working directory at the time of
# running is the **new** application and the `applicationPath` which is
# passed as an argument is the place where the **new** application should be moved to
# in order to activate it.
#
# Short Description: Deployment move script
# Usage: runHook deploy-move applicationPath
# Argument: applicationPath - This is the target for the current application
# Exit code: 0 - This is called to replace the running application in-place
#

hookDeployMove() {
    consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
}

hookDeployMove
