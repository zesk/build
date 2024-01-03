#!/usr/bin/env bash
#
# Run during bin/build/pipeline/report-deploy-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Delete any temporary files left over from deployment and finish deployment.
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

#
# fn: {base}
# Summary: Run after a successful deployment
# Run on remote systems after deployment has succeeded on all systems.
#
# This step must always succeed on the remote system; the deployment step prior to this
# should do wahtever is required to ensure that.
#
hookDeployCleanup() {
    consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
}

hookDeployCleanup "$@"
