#!/bin/bash
#
# Original of returnClean
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ returnClean EOF

# Delete files or directories and return the same exit code passed in.
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: isUnsignedInteger _argument __environment
returnClean() {
  local exitCode="${1-}" && shift
  isUnsignedInteger "$exitCode" || _argument "${FUNCNAME[0]} $exitCode (not an integer) $*" || return $?
  __environment rm -rf "$@" || return "$exitCode"
  return "$exitCode"
}
