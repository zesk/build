#!/usr/bin/env bash
#
# Run during bin/build/pipeline/report-deploy-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# End of deployment to system, update local settings or register server before
# maintenance is turned off.
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

#
# fn: {base}
# Short Description: Deployment "finish" script
#
# Exit code: 0 - This SHOULD exit successfully always
#
# Example: - Move directories to make deployment final
hookDeployFinish() {
    consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
}

hookDeployFinish
