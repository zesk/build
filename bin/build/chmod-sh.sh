#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `makeShellFilesExecutable` for arguments and usage.
# See: makeShellFilesExecutable
__binMakeShellFilesExecutable() {
  # IDENTICAL makeShellFilesExecutable 1
  find . -name '*.sh' -type f ! -path '*/.*' "$@" -print0 | xargs -0 chmod -v +x
}
__binMakeShellFilesExecutable "$@"
