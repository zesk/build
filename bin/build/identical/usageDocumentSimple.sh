#!/bin/bash
#
# Identical template
#
# Original of usageDocument
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL usageDocumentSimple EOF

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - Optional. String. Message to display to the user.
# Requires: bashFunctionComment decorate read printf exitString __help usageDocument
usageDocumentSimple() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" color helpColor="info" icon="❌" line prefix="" finished=false skip=false && shift 3

  case "$returnCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="bold-red" ;; *) color="orange" ;; esac
  [ "$returnCode" -eq 0 ] || exec 1>&2
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(exitString "$returnCode")")" "$(decorate "$color" "$*")"
  if [ ! -f "$source" ]; then
    export BUILD_HOME
    [ -d "${BUILD_HOME-}" ] || _argument "Unable to locate $source (${PWD-})" || return $?
    source="$BUILD_HOME/$source"
    [ -f "$source" ] || _argument "Unable to locate $source (${PWD-})" || return $?
  fi
  while ! $finished; do
    IFS='' read -r line || finished=true
    printf "%s%s\n" "$prefix" "$(decorate "$helpColor" "$line")"
    prefix=""
  done < <(bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g")
  return "$returnCode"
}
_usageDocumentSimple() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
