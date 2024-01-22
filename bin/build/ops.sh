#!/usr/bin/env bash
#
# Shell colors
#
# Usage: source ./bin/build/tools.sh
#
# Depends: -
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

opsDir="$(dirname "${BASH_SOURCE[0]}")/ops"

# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/tools.sh"

# Operations

# shellcheck source=/dev/null
. "$opsDir/daemontools.sh"

if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
  # Only require when running as a shell command
  set -eou pipefail
  # Run remaining command line arguments
  "$@"
fi
