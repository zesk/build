#!/usr/bin/env bash
#
# Run during bin/build/pipeline/report-deploy-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# End of deployment to system, update local settings or register server before
# maintenance is turned off.
#
set -eo pipefail

errEnv=1
me=$(basename "${BASH_SOURCE[0]}")
if ! cd "$(dirname "${BASH_SOURCE[0]}")/../.."; then
    echo "$me: Can not cd" && exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
