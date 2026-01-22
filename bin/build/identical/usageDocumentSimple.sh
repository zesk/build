#!/bin/bash
#
# Identical template
#
# Original of usageDocument
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL usageDocumentSimple EOF

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - String. Optional. Message to display to the user.
# Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached
usageDocumentSimple() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" color helpColor="info" icon="❌" skip=false && shift 3

  case "$returnCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="red" ;; *) color="orange" ;; esac
  [ "$returnCode" -eq 0 ] || exec 1>&2
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(returnCodeString "$returnCode")")" "$(decorate BOLD "$color" "$*")"
  export BUILD_HOME
  if [ ! -f "$source" ]; then
    [ -d "${BUILD_HOME-}" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
    source="$BUILD_HOME/$source"
    [ -f "$source" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
  fi
  if ! __usageDocumentCached "$handler" "${BUILD_HOME-}" "${functionName}"; then
    bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g" | decorate "$helpColor"
  fi
  return "$returnCode"
}
_usageDocumentSimple() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
