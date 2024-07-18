#!/bin/bash
#
# Original of __install
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Requires: IDENTICAL _return
# Example: __install ../../.. bin consoleOrange "$@"

# IDENTICAL __install EOF
# Load build tools (installing if needed) and run command
# Usage: {fn} [ relative [ command ... ] ]
# Argument: relative - Required. Directory. Path to application root.
# Argument: installPath - Optional. RelativeDirectory. Path relative to application root to `install-bin-build.sh`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__install() {
  local relative="${1:-".."}" installPath="${2-bin}"
  local source="${BASH_SOURCE[0]}" internalError=253
  local here="${source%/*}"
  local install="$here/$relative/$installPath/install-bin-build.sh"
  local tools="$here/$relative/bin/build"
  if [ ! -d "$tools" ]; then
    [ -x "$install" ] || _return $internalError "$install not executable" || return $?
    "$install" || _return $internalError "$install failed" "$@" || return $?
  fi
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $internalError "$install failed to create $tools" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $internalError source "$tools" "$@" || return $?
  shift && shift
  [ $# -eq 0 ] && return 0
  __return "$@" || return $?
}
