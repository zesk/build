#!/usr/bin/env bash
#
# Run after tests are run to clean up the environment or artifacts from testing
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleSuccess "Test cleanup does nothing - please rewrite"
