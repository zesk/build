#!/bin/bash
#
# Identical template
#
# Original of bashDocumentation
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL bashSimpleDocumentation EOF

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - String. Optional. Message to display to the user.
# Requires: bashFunctionComment decorate read printf returnCodeString helpArgument bashDocumentation __bashDocumentationCached __usageMessageStyle __usageMessage
bashSimpleDocumentation() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" && shift 3

  [ "$returnCode" -eq 0 ] || exec 3>&1 1>&2
  if ! __bashDocumentationCached "$handler" "${BUILD_HOME-}" "${functionName}" "$returnCode" "$@"; then
    __usageMessage "$returnCode" "$@" || return $?
    export BUILD_HOME
    if [ ! -f "$source" ]; then
      [ -d "${BUILD_HOME-}" ] || returnArgument "Unable to locate $source (PWD: \"${PWD-}\", BUILD_HOME?: \"${BUILD_HOME-}\")" || return $?
      source="$BUILD_HOME/$source"
      [ -f "$source" ] || returnArgument "Unable to locate $source (PWD: \"${PWD-}\", BUILD_HOME: \"${BUILD_HOME-}\")" || return $?
    fi
    bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g" | __usageMessageStyle "$returnCode"
  fi
  [ "$returnCode" -eq 0 ] || exec 1>&3 3>&-
  return "$returnCode"
}
_bashSimpleDocumentation() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
