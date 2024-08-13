#!/bin/bash
#
# Dead simple PHP build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __install 17
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

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__buildSampleApplication() {
  clearLine || return $?
  __environment phpBuild --deployment staging --skip-tag "$@" -- simple.application.php public src docs || return $?
}

__install .. bin __buildSampleApplication "$@"
