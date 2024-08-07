#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh before tagging
#
# Add any files to your repository here and commit them automatically if they need to be
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 16
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local source="${BASH_SOURCE[0]}" e=253
  local here="${source%/*}" arguments=()
  local tools="$here/${1:-".."}/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh" && [ -x "$tools" ] || _return $e "$tools not executable" "$@" || return $?
  shift && while [ $# -gt 0 ]; do arguments+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" "$@" || return $?
  [ ${#arguments[@]} -gt 0 ] || return 0
  "${arguments[@]}" || return $?
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

# fn: {base}
#
# We need to fetch an unshallow version for deployment to GitHub
#
__hookGithubReleaseBefore() {
  ! buildDebugEnabled || consoleInfo "${FUNCNAME[0]} does nothing. Nice!"
}

__tools ../.. __hookGithubReleaseBefore "$@"
