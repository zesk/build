#!/usr/bin/env bash
#
# Run during bin/build/pipeline/php-deploy.sh
#
# Run in the pipeline, used to check smoke test on remote systems: did our deployment work?
#
# If not, fail and it will undo it.
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced with live smoke tests"

# Some examples:
#
# - Enable a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
# - Check the home page for a version number
# - Check for a known artifact (build sha) in the server somehow
# - etc.
