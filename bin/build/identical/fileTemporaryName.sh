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
# Argument: handler - Function. Required. Function to call if mktemp fails. Function Type: _return
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ... - Optional. Arguments. Any additional arguments are passed through to mktemp.
# Requires: __help __catchEnvironment mktemp usageDocument
fileTemporaryName() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  handler="$1" && shift
  __catchEnvironment "$handler" mktemp "$@" || return $?
}
_fileTemporaryName() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName
