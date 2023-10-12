#!/usr/bin/env bash
#
# Run before tests are run and before environment is built for testing
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleSuccess "Test setup does nothing - please rewrite"
