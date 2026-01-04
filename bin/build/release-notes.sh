#!/usr/bin/env bash
#
# release-notes.sh
#
# Current release notes file path
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# See: releaseNotes
#

# fn: {base}
# Usage: {fn}
# See `releaseNotes` for arguments and usage.
# See: releaseNotes
__binReleaseNotes() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" releaseNotes "$@"
}

__binReleaseNotes "$@"
