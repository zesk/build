#!/usr/bin/env bash
#
# Run during bin/build/pipeline/report-deploy-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Do any steps after a deployment fails to undo and restore the previous deployment on a host
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# After a deployment was successful on a host, this undos that deployment and goes back to the previous version.
#
# fn: {base}
# Summary: Deployment "undo" script
#
# Exit code: 0 - This SHOULD exit successfully always
hookDeployUndo() {
    consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
}

hookDeployUndo
