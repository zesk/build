#!/usr/bin/env bash
#
# test.sh
#
# Testing
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

__buildTestSuite() {
  local usage="_${FUNCNAME[0]}"
  local here="${BASH_SOURCE[0]%/*}"
  testTools testSuite --tests "$(realPath "${here%/*}/../test/tools")" "$@" || __failEnvironment "$usage" "testTools" || return $?
}
___buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools .. __buildTestSuite "$@"
