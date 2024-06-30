#!/usr/bin/env bash
#
# identical-repair.sh
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

__buildIdenticalRepair() {
  local defaultSingles="etc/identical-check-singles.txt"
  local aa
  export BUILD_HOME
  __environment buildEnvironmentLoad BUILD_HOME || return $?
  __environment cd "$BUILD_HOME" || return $?
  aa=()
  [ ! -f "$BUILD_HOME/$defaultSingles" ] || aa+=(--singles "$BUILD_HOME/$defaultSingles")
  __environment identicalCheckShell "${aa[@]+"${aa[@]}"}" --exec contextOpen --repair "$BUILD_HOME/bin/build/identical" "$@" || return $?
}

__tools ../.. __buildIdenticalRepair "$@"

# EOF
