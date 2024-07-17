#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 18
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
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

# IDENTICAL _return 15
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
_integer() { case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac }

__hookPreCommit() {
  local usage="_${FUNCNAME[0]}"
  # gitPreCommitSetup is already called
  local fileCopies nonOriginalWithEOF nonOriginal original

  gitPreCommitListExtension @ | wrapLines "- $(consoleValue)" "$(consoleReset)"
  gitPreCommitHeader sh md json

  statusMessage consoleSuccess Updating help files ...
  __usageEnvironment "$usage" ./bin/update-md.sh || return $?

  statusMessage consoleSuccess Updating _sugar.sh
  original="bin/build/identical/_sugar.sh"
  nonOriginal=bin/build/tools/_sugar.sh

  if [ "$(newestFile "$original" "$nonOriginal")" = "$nonOriginal" ]; then
    nonOriginalWithEOF=$(__usageEnvironment "$usage" mktemp) || return $?
    __usageEnvironment "$usage" sed 's/IDENTICAL _sugar [0-9][0-9]*/IDENTICAL _sugar EOF/g' <"$nonOriginal" >"$nonOriginalWithEOF" || return $?
    fileCopies=("$nonOriginalWithEOF" "$original")
    # Can not be trusted to not edit the right one
    if ! diff -q "${fileCopies[@]}" 2>/dev/null; then
      __usageEnvironment "$usage" cp "${fileCopies[@]}" || _clean "$nonOriginalWithEOF" || return $?
      consoleWarning "Someone edited non-original file $nonOriginal"
      touch "${fileCopies[0]}" # make newer
    fi
    rm -f "$nonOriginalWithEOF" || :
  fi
  if gitPreCommitHasExtension sh; then
    if ! bin/build/identical-repair.sh && ! bin/build/identical-repair.sh; then
      __failEnvironment "$usage" "Identical repair failed twice - manual intervention required" || return $?
    fi
  fi

}
___hookPreCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. __hookPreCommit "$@"
