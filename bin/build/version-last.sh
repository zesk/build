#!/usr/bin/env bash
#
# version-last.sh - Last version
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `gitVersionLast` for arguments and usage.
# See: gitVersionLast
# Requires: dirname gitVersionLast
__binGitVersionLast() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" gitVersionLast "$@"
}

__binGitVersionLast "$@"
