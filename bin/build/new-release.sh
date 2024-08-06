#!/bin/bash
#
# new-release.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `newRelease` for arguments and usage.
# See: newRelease
__binNewRelease() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" newRelease "$@"
}

__binNewRelease "$@"
