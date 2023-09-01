#!/usr/bin/env bash
#
# Run during bin/build/pipeline/php-deploy.sh
#
# Run in the pipeline, used to check smoke test on remote systems: did our deployment work?
#
# If not, fail.
#
set -eo pipefail

errEnv=1
me=$(basename "${BASH_SOURCE[0]}")
relTop=../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd $relTop"
    exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced with live smoke tests"

# Some examples:
#
# - Put a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
# - Check the home page for a version number
# - etc.
