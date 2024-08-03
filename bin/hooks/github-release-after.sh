#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh after release is completed
#
# Do any post-release steps you want (update your website etc.)
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 17
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local source="${BASH_SOURCE[0]}" e=253
  local here="${source%/*}"
  local tools="$here/${1:-".."}/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $e "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# END of IDENTICAL _return

# fn: {base}
#
# Optional hook run during `github-release.sh` after release is completed. Do any post-release work here.
#
__hookGithubReleaseAfter() {
  ! buildDebugEnabled || consoleSuccess "$(basename "${BASH_SOURCE[0]}") is the sample script, please update for production sites."
}

__tools ../.. __hookGithubReleaseAfter "$@"
