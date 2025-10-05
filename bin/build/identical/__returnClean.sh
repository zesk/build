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
# Requires: isUnsignedInteger returnArgument returnThrowEnvironment usageDocument returnThrowArgument
# Group: Sugar
returnClean() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local exitCode="${1-}" && shift
  if ! isUnsignedInteger "$exitCode"; then
    returnThrowArgument "$handler" "$exitCode (not an integer) $*" || return $?
  else
    catchEnvironment "$handler" rm -rf "$@" || return "$exitCode"
    return "$exitCode"
  fi
}
_returnClean() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
