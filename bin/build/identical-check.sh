#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Utility to check source code for identical sections which MUST match to succeed.
#
# See: identicalCheck

# fn: {base}
# Usage: {fn}
# See `identicalCheck` for arguments and usage.
# See: identicalCheck
__binIdenticalCheck() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" identicalCheck "$@"
}

__binIdenticalCheck "$@"
