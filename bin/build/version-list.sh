#!/usr/bin/env bash
#
# markdown_removeUnfinishedSections.sh - List versions
#
# Depends: git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `gitVersionLast` for arguments and usage.
# See: gitVersionLast
__binGitVersionList() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" gitVersionList "$@"
}

__binGitVersionList "$@"
