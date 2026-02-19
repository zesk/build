#!/bin/bash
#
# Identical template
#
# Original of __usageDocumentCached
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL __usageDocumentCached EOF

# Argument: handler - Function. Required.
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to display usage for
# Argument: returnCode - UnsignedInteger. Optional. Exit code to display. Defaults to `0` - no error.
# Argument: message ... - String. Optional. Display this message which describes why `exitCode` occurred.
# Environment: BUILD_COLORS
# Requires: decorateThemed catchEnvironment __usageMessage decorate
__usageDocumentCached() {
  local handler="$1" && shift
  local home="$1" && shift
  local functionName="$1" && shift
  local suffix="bin/build/documentation/$functionName.sh"
  local settingsFile="$home/$suffix"
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
