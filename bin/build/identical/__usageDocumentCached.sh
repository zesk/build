#!/bin/bash
#
# Identical template
#
# Original of __usageDocumentCached
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL __usageDocumentCached EOF

# Summary: Display cached usage for a function
# Argument: handler - Function. Required.
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to display usage for
# Argument: returnCode - UnsignedInteger. Optional. Exit code to display. Defaults to `0` - no error.
# Argument: message ... - String. Optional. Display this message which describes why `exitCode` occurred.
# Environment: BUILD_COLORS
# Environment: BUILD_DOCUMENTATION_PATH
# Requires: decorateThemed catchEnvironment __usageMessage decorate
__usageDocumentCached() {
  local handler="$1" && shift
  local home="$1" && shift
  local functionName="$1" && shift
  export BUILD_DOCUMENTATION_PATH
  local paths && IFS=":" read -r -d $'\n' -a paths <<<"${BUILD_DOCUMENTATION_PATH-"bin/build/documentation"}"
  local settingsFile="" path && for path in "${paths[@]+"${paths[@]}"}"; do
    settingsFile="$home/${path%/}/$functionName.sh"
    [ ! -f "$settingsFile" ] || break
  done
  [ -f "$settingsFile" ] || return 1
  decorateInitialized || decorate info -- || return $?
  (
    local helpConsole="" helpPlain=""
    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settingsFile" || return $?
    if [ "${BUILD_COLORS-}" != "false" ] && [ -n "$helpConsole" ]; then
      __usageMessage "$@" || return $?
      catchEnvironment "$handler" decorateThemed <<<"$helpConsole" || return $?
    else
      [ -n "$helpPlain" ] || return 1
      __usageMessage "$@" || return $?
      catchEnvironment "$handler" printf "%s\n" "$helpPlain" || return $?
    fi
  ) || return $?
}
