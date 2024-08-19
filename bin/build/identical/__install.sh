#!/bin/bash
#
# Identical template
#
# Original of __install
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Requires: IDENTICAL _return
# Example: __install ../../.. bin/install-bin-build.sh bin/build/tools.sh consoleOrange "$@"

# IDENTICAL __install EOF
# Load build tools (installing if needed) and run command
# Usage: {fn} [ relativeHome installer include [ command ... ] ]
# Argument: relative - Required. Directory. Path to application home.
# Argument: installer - Optional. File. Installation binary.
# Argument: include - Optional. File. Include file which should exist after installation.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__install() {
  local relative="${1:-".."}" installer="${2-}" include="${3-}" source="${BASH_SOURCE[0]}"
  local here="${source%/*}" e=253 arguments=()
  local install="$here/$relative/$installer" tools="$here/$relative/$include"
  [ -n "$installer" ] || _return $e "blank installer" || return $?
  [ -n "$include" ] || _return $e "blank include" || return $?
  if [ ! -x "$tools" ]; then
    "$install" || _return $e "$install failed" || return $?
    [ -d "${tools%/*}" ] || _return $e "$install failed to create directory ${tools%/*}" || return $?
  fi
  [ -x "$tools" ] || _return $e "$install failed to create $tools" "$@" || return $?
  shift && shift && shift && while [ $# -gt 0 ]; do arguments+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" || return $?
  [ ${#arguments[@]} -gt 0 ] || return 0
  __return "${arguments[@]}" || return $?
}
