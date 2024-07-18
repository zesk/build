#!/bin/bash
#
# Original of __ops
#
# requires IDENTICAL _return
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __ops EOF
# Usage: __tools command ...
# Load zesk build and run command
# DEPRECATED 2024-07-15
# Use __tools instead
__ops() {
  local relative="${1:-".."}"
  local source="${BASH_SOURCE[0]}" internalError=253
  local here="${source%/*}"
  local tools="$here/$relative/bin/build"
  [ -d "$tools" ] || _return $internalError "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $internalError "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $internalError source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}
