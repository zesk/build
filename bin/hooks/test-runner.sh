#!/usr/bin/env bash
#
# Runs our tests on the built environment
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then
  # Runs our tests; any non-zero exit code is considered a failure and will terminate
  # deployment steps.
  #
  # The default hook for this fails with exit code 99 by default.
  # Return Code: 0 - If the tests all pass
  # Return Code: Non-Zero - If any test fails for any reason
  #
  # fn: {base}
  __hookTestRunner() {
    ! buildDebugEnabled || decorate error "Test runner does nothing, failing, rewrite this."
    return 99
  }

  __hookTestRunner "$@"
fi
