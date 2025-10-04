#!/bin/bash
#
# new-release.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `releaseNew` for arguments and usage.
# See: releaseNew
__binReleaseNew() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" releaseNew "$@"
}

__binReleaseNew "$@"
