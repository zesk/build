#!/usr/bin/env bash
#
# test.sh
#
# Testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Test locally:
# bin/local-container.sh
# . bin/test-reset.sh; bin/test.sh

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

__buildTestSuite() {
  local usage="_${FUNCNAME[0]}"
  local here="${BASH_SOURCE[0]%/*}"
  # shellcheck source=/dev/null
  testTools || __failEnvironment "$usage" "testTools" || return $?
  testSuite --tests "$(realPath "${here%/*}/../test/tools")" "$@"
}
___buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools .. __buildTestSuite "$@"
