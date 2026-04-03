#!/bin/bash
#
# Identical template
#
# Original of fileTemporaryName
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL fileTemporaryName EOF

# Wrapper for `mktemp`. Generate a temporary file name, and fail using a function
# Argument: handler - Function. Required. Function to call on failure. Function Type: returnMessage
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: ... - Arguments. Optional. Any additional arguments are passed through.
# Requires: mktemp __help catchEnvironment bashDocumentation
# BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks
# Environment: BUILD_DEBUG
fileTemporaryName() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  handler="$1" && shift
  local debug=",${BUILD_DEBUG-},"
  if [ "${debug#*,temp,}" != "$debug" ]; then
    local target="${BUILD_HOME-.}/.${FUNCNAME[0]}"
    printf "%s" "fileTemporaryName: " >>"$target"
    catchEnvironment "$handler" mktemp "$@" | tee -a "$target" || return $?
    local sources=() count=${#FUNCNAME[@]} index=0
    while [ "$index" -lt "$count" ]; do
      sources+=("${BASH_SOURCE[index + 1]-}:${BASH_LINENO[index]-"$LINENO"} - ${FUNCNAME[index]-}")
      index=$((index + 1))
    done
    printf "%s\n" "${sources[@]}" "-- END" >>"$target"
  else
    catchEnvironment "$handler" mktemp "$@" || return $?
  fi
}
_fileTemporaryName() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName
