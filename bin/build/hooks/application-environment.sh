#!/usr/bin/env bash
#
# Fetch an ID which represents the current application build/code state which is unique
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
#
# Hook to customize the application environment file
#
# See: environmentFileApplicationMake
__hookApplicationEnvironment() {
  environmentFileApplicationMake "$@"
}

__hookApplicationEnvironment "$@"
