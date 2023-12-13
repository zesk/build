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
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# Deployment "start" script
#
# fn: {base}
# Exit code: 0 - This SHOULD exit successfully always
# Example: - Move directories to make deployment final
hookDeployStart() {
    consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
}

hookDeployStart
