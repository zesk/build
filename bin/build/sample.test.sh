#!/usr/bin/env bash
#
# sample.test.sh
#
# Testing script wrapper
#
# Copy this into your project to ./bin/test.sh (change the last line!)
#
# Add functions called `testSomething` to `test/tests/nameOfYourModule-tests.sh`
#
# Your tests will run using the `testSuite` framework.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __source 19
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
__source() {
  local me="${BASH_SOURCE[0]}" e=253
  local here="${me%/*}" a=()
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  while [ $# -gt 0 ]; do a+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}

# Test Zesk Build
# See: testSuite
__buildTestSuite() {
  local here="${BASH_SOURCE[0]%/*}"
  local testHome

  testHome="$(__environment buildHome)" || return $?
  # Include our own test support files if needed
  [ ! -d "$testHome/test/support" ] || __environment bashSourcePath "$testHome/test/support" || return $?
  testTools testSuite --tests "$testHome/test/tests/" "$@" || return $?
}
___buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. __buildTestSuite "$@"
