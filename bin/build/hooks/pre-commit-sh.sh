#!/usr/bin/env bash
#
# Part of build system integration with git
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

#
# The `git-pre-commit` hook self-installs as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# It will:
# 1. Updates the help file templates
# 2. Checks all shell files for errors
# fn: {base}
__hookPreCommitShell() {
  local file changed
  local usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" gitPreCommitListExtension sh | wrapLines "- $(consoleBoldMagenta)" "$(consoleReset)"
  changed=()
  while read -r file; do changed+=("$file"); done < <(gitPreCommitListExtension sh)
  __usageEnvironment "$usage" bashSanitize "${changed[@]}" || return $?
}
___hookPreCommitShell() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../../.. __hookPreCommitShell "$@"
