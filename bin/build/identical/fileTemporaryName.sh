#!/bin/bash
#
# Identical template
#
# Original of fileTemporaryName
#
# Wrapper for mktemp
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL fileTemporaryName EOF
# Generate a temporary file name using mktemp, and fail using a function
# Argument: usage - Function. Required. Function to call if mktemp fails
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ... - Optional. Arguments. Any additional arguments are passed through to mktemp.
# Requires: __help __usageEnvironment mktemp usageDocument
fileTemporaryName() {
  local usage="_${FUNCNAME[0]}"
  __help "$usage" "$@" || return 0
  usage="$1" && shift
  __usageEnvironment "$usage" mktemp "$@" || return $?
}
_fileTemporaryName() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName
