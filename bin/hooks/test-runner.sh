#!/usr/bin/env bash
#
# Runs our tests on the built environment
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleError "Test runner does nothing, failing, rewrite this."
exit 99
