#!/bin/bash
#
# Identical template
#
# Original of usageDocument
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL __usageDocumentCached EOF

# Argument: handler - Function. Required.
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to display usage for
# Environment: BUILD_COLORS
# Requires: decorateThemed catchEnvironment
__usageDocumentCached() {
  local handler="${1-}" && shift
  local home="${1-}" && shift
  local functionName="${1-}" && shift
  local settingsFile="$home/bin/build/documentation/$functionName.sh"
  [ -f "$settingsFile" ] || return 1
  (
    set -a
    export helpConsole helpPlain
    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settingsFile" || return $?
    if [ "${BUILD_COLORS-}" != "false" ]; then
      catchEnvironment "$handler" decorateThemed <<<"$helpConsole" || return $?
    else
      catchEnvironment "$handler" printf "%s\n" "$helpPlain" || return $?
    fi
  ) || return $?
}
