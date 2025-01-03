#!/bin/bash
#
# cannon.sh
#
# Replace all occurrences of one string with another in a directory of files.
#
# Use caution!
#
# See: cannon
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `cannon` for arguments and usage.
# See: cannon
__binCannon() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" cannon "$@"
}

__binCannon "$@"
