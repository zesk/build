#!/bin/bash
#
# Identical template
#
# Original of fileTemporaryName
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL fileTemporaryName EOF

# Wrapper for `mktemp`. Generate a temporary file name, and fail using a function
# Argument: handler - Function. Required. Function to call on failure. Function Type: _return
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ... - Optional. Arguments. Any additional arguments are passed through.
# Requires: mktemp __help __catchEnvironment usageDocument
# BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks
fileTemporaryName() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  handler="$1" && shift
  local debug=";${BUILD_DEBUG-};"
  if [ "${debug#*;temp;}" != "$debug" ]; then
    local target
    target="$(buildHome)/.${FUNCNAME[0]}"
    printf "%s" "fileTemporaryName: " >>"$target"
    __catchEnvironment "$handler" mktemp "$@" | tee -a "$target" || return $?
    debuggingStack >>"$target"
    printf "%s\n" "-- END" >>"$target"
  else
    __catchEnvironment "$handler" mktemp "$@" || return $?
  fi
}
_fileTemporaryName() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName
