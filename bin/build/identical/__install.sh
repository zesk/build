#!/bin/bash
#
# Identical template
#
# Original of __install
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Requires: IDENTICAL _return
# Example: __install ../../.. bin consoleOrange "$@"

# IDENTICAL __install EOF
# Load build tools (installing if needed) and run command
# Usage: {fn} [ relative installPath [ command ... ] ]
# Argument: relative - Required. Directory. Path to application root.
# Argument: installPath - Optional. RelativeDirectory. Path relative to application root to `install-bin-build.sh`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__install() {
  local relative="${1:-".."}" installPath="${2-bin}" source="${BASH_SOURCE[0]}"
  local here="${source%/*}" e=253 arguments=()
  local install="$here/$relative/$installPath/install-bin-build.sh" tools="$here/$relative/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh" && [ -x "$tools" ] || _return $e "$install failed to create $tools" "$@" || return $?
  shift && shift && while [ $# -gt 0 ]; do arguments+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" || return $?
  [ ${#arguments[@]} -gt 0 ] || return 0
  __return "${arguments[@]}" || return $?
}
