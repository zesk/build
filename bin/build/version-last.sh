#!/usr/bin/env bash
#
# version-last.sh - Last version
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `gitVersionLast` for arguments and usage.
# See: gitVersionLast
# Requires: dirname gitVersionLast
__binGitVersionLast() {
  "${BASH_SOURCE[0]%/*}/tools.sh" gitVersionLast "$@"
}

__binGitVersionLast "$@"
