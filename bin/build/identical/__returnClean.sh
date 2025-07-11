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
# Requires: isUnsignedInteger _argument __environment usageDocument
returnClean() {
  local exitCode="${1-}" && shift
  if ! isUnsignedInteger "$exitCode"; then
    local this="${FUNCNAME[0]}"
    [ "$exitCode" = "--help" ] && usageDocument "$this" "${BASH_SOURCE[0]}" 0 || _argument "$this $exitCode (not an integer) $*" || return $?
  else
    __environment rm -rf "$@" || return "$exitCode"
    return "$exitCode"
  fi
}
