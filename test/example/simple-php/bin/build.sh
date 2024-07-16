#!/bin/bash
#
# Dead simple PHP build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __install 23
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

# IDENTICAL _return 14
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift && : || _integer "$r" || _return 2 "${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() { case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac }

__buildSampleApplication() {
  clearLine || return $?
  __environment phpBuild --deployment staging --skip-tag "$@" -- simple.application.php public src docs || return $?
}

__install .. bin __buildSampleApplication "$@"
