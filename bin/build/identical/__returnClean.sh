#!/bin/bash
#
# Original of returnClean
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# _IDENTICAL_ returnClean EOF

# Delete files or directories and return the same exit code passed in.
# Argument: exitCode - Integer. Required. Exit code to return.
# Argument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument helpArgument
# Group: Sugar
returnClean() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local exitCode="${1-}" && shift
  if ! isUnsignedInteger "$exitCode"; then
    throwArgument "$handler" "$exitCode (not an integer) $*" || return $?
  else
    catchEnvironment "$handler" rm -rf "$@" || return "$exitCode"
    return "$exitCode"
  fi
}
_returnClean() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
