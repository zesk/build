#!/bin/bash
#
# Identical template
#
# Original of __install
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __install EOF

# Load a bash script (installing if needed) and run an optional command
# Argument: installer - Required. File. Installation binary.
# Argument: source - Required. File. Include file which should exist after installation.
# Argument: relativeHome - Optional. Directory. Path to application home. Default is `..`.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Example:      __install bin/install-bin-build.sh bin/build/tools.sh ../../.. decorate info "$@"
# Requires: returnMessage execute
__install() {
  local installer="${1-}" source="${2-}" relativeHome="${3:-".."}" me="${BASH_SOURCE[0]}"
  local here="${me%/*}" e=253 a
  local install="$here/$relativeHome/$installer" tools="$here/$relativeHome/$source"
  [ -n "$installer" ] || returnMessage $e "blank installer" || return $?
  [ -n "$source" ] || returnMessage $e "blank source" || return $?
  if [ ! -x "$tools" ]; then
    "$install" || returnMessage $e "$install failed" || return $?
    [ -d "${tools%/*}" ] || returnMessage $e "$install failed to create directory ${tools%/*}" || return $?
  fi
  [ -x "$tools" ] || returnMessage $e "$install failed to create $tools" "$@" || return $?
  shift 3 && a=("$@") && set --
  # shellcheck source=/dev/null
  source "$tools" || returnMessage "$e" source "$tools" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  execute "${a[@]}" || return $?
}
