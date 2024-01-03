#!/usr/bin/env bash
#
# Run after tests are run to clean up the environment or artifacts from testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

#
# Runs after tests have been run to clean up any artifacts or other test files which
# may have been generated.
#
# fn: {base}
hookTestCleanup() {
    consoleSuccess "Test cleanup does nothing - please rewrite"
}

hookTestCleanup "$@"
