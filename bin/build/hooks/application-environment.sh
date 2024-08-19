#!/usr/bin/env bash
#
# Generate the .env file
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# Hook is run to generate the application environment file
# Outputs environment settings, one per line to be put into an environment file
# Usage: {fn}
# See `environmentFileApplicationMake` for usage and arguments.
# See: environmentFileApplicationMake
__hookApplicationEnvironment() {
  __return environmentFileApplicationMake "$@" || return $?
}

__hookApplicationEnvironment "$@"
