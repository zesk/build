#!/usr/bin/env bash
#
# Run before tests are run and before environment is built for testing
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then
  #
  # Sets up our environment for our tests. May build a test image, set up a test database, start a test version of the
  # system, or deploy to a test environment for testing.
  #
  # The default hook does nothing and exits successfully.
  #
  # Return Code: 0 - If the test setup was successful
  # Return Code: Non-Zero - Any error will terminate testing
  #
  # fn: {base}
  __hookTestSetup() {
    ! buildDebugEnabled || decorate success "Test setup does nothing - please rewrite"
  }

  __hookTestSetup "$@"
fi
