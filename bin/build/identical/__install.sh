#!/bin/bash
#
# Identical template
#
# Original of __install
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Requires: IDENTICAL _return

# IDENTICAL __install EOF
# Load build tools (installing if needed) and run command
# Usage: {fn} [ relativeHome installer source [ command ... ] ]
# Argument: installer - Required. File. Installation binary.
# Argument: source - Required. File. Include file which should exist after installation.
# Argument: relativeHome - Optional. Directory. Path to application home. Default is `..`.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Example:      __install bin/install-bin-build.sh bin/build/tools.sh ../../.. consoleOrange "$@"
__install() {
  local installer="${1-}" source="${2-}" relativeHome="${1:-".."}" me="${BASH_SOURCE[0]}"
  local here="${me%/*}" e=253 arguments=()
  local install="$here/$relativeHome/$installer" tools="$here/$relativeHome/$source"
  [ -n "$installer" ] || _return $e "blank installer" || return $?
  [ -n "$source" ] || _return $e "blank source" || return $?
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
