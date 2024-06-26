#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 12
# Load zesk build and run command
__tools() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/tools.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
}

__hookPreCommit() {
  local usage="_${FUNCNAME[0]}"
  # gitPreCommitSetup is already called
  local fileCopies

  gitPreCommitListExtension @ | wrapLines "- $(consoleValue)" "$(consoleReset)"
  gitPreCommitHeader sh md json

  statusMessage consoleSuccess Updating help files ...
  __usageEnvironment "$usage" ./bin/update-md.sh || return $?

  statusMessage consoleSuccess Updating _sugar.sh
  fileCopies=(bin/build/identical/_sugar.sh bin/build/tools/_sugar.sh)
  # Can not be trusted to not edit the wrong one
  if ! diff -q "${fileCopies[@]}"; then
    __usageEnvironment "$usage" cp -f "$(newestFile "${fileCopies[@]}")" "$(oldestFile "${fileCopies[@]}")"
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
