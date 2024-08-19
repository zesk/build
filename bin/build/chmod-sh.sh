#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `makeShellFilesExecutable` for arguments and usage.
# See: makeShellFilesExecutable
__binMakeShellFilesExecutable() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" makeShellFilesExecutable "$@"
}
__binMakeShellFilesExecutable "$@"
