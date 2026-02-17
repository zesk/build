#!/bin/bash
#
# Identical template
#
# Original of usageDocument
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL __usageDocumentCached EOF

# Output the error message for usage consistently
# Argument: returnCode - UnsignedInteger. Required. Exit code to display
# Argument: message ... - String. Optional. Display this message which describes why `exitCode` occurred.
# Requires: decorateThemed catchEnvironment __usageTemplateMessage decorate
__usageTemplateMessage() {
  local returnCode="$1" && shift
  if [ $# -gt 0 ] && [ -n "$*" ]; then
    if [ "$returnCode" -eq 0 ]; then
      printf "%s\n\n" "$(decorate success "$@")"
    elif [ "$returnCode" != 2 ]; then
      printf "%s %s\n" "$(decorate error "[$(returnCodeString "$returnCode")]")" "$(decorate code "$@")"
      return "$returnCode"
    else
      printf "%s %s\n" "$(decorate warning "[$(returnCodeString "$returnCode")]")" "$(decorate code "$@")"
    fi
  fi
}

# Argument: handler - Function. Required.
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to display usage for
# Argument: returnCode - UnsignedInteger. Optional. Exit code to display. Defaults to `0` - no error.
# Argument: message ... - String. Optional. Display this message which describes why `exitCode` occurred.
# Environment: BUILD_COLORS
# Requires: decorateThemed catchEnvironment __usageTemplateMessage decorate
__usageDocumentCached() {
  local handler="$1" && shift
  local home="$1" && shift
  local functionName="$1" && shift
  local stqrt="$1" && shift
  local returnCode="${1-0}"
  local suffix="bin/build/documentation/$functionName.sh"
  local settingsFile="$home/$suffix"
  [ -f "$settingsFile" ] || return 1
  : "$stqrt"
  decorateInitialized || decorate info -- || return $?
  (
    local helpConsole="" helpPlain=""
    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settingsFile" || return $?
    if [ "${BUILD_COLORS-}" != "false" ] && [ -n "$helpConsole" ]; then
      __usageTemplateMessage "$@" || return $?
      catchEnvironment "$handler" decorateThemed <<<"$helpConsole" || return $?
    else
      [ -n "$helpPlain" ] || return 1
      __usageTemplateMessage "$@" || return $?
      catchEnvironment "$handler" printf "%s\n" "$helpPlain" || return $?
    fi
  ) || return $?
}
