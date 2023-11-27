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

#
# Runs our tests; any non-zero exit code is considered a failure and will terminate
# deployment steps.
#
# The default hook for this fails with exit code 99 by default.
# Exit Code: 0 - If the tests all pass
# Exit Code: Non-Zero - If any test fails for any reason
#
# fn: {base}
hookTestRunner() {
    consoleError "Test runner does nothing, failing, rewrite this."
    return 99
}

hookTestRunner "$@"
