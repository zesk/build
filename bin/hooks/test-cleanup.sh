#!/usr/bin/env bash
#
# Run after tests are run to clean up the environment or artifacts from testing
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # Runs after tests have been run to clean up any artifacts or other test files which
  # may have been generated.
  #
  # fn: {base}
  __hookTestCleanup() {
    ! buildDebugEnabled || decorate success "Test cleanup does nothing - please rewrite"
  }

  __hookTestCleanup "$@"
fi
