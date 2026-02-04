#!/usr/bin/env bash
#
# junit.xml Generation functions
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/junit.md
# Test: ./test/tools/junit-tests.sh

# Open tag for `testsuites`
#
# Example:     <testsuites name="Test run" tests="8" failures="1" errors="1" skipped="1"
# Example:                assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23">
#
# Attributes:
# - `name=Test run`
# - `tests=8`
# - `failures=1`
# - `errors=1`
# - `skipped=1`
# - `assertions=20`
# - `time=16.082687`
# - `timestamp=2021-04-02T15:48:23`
# Argument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen testsuites "$@" name="" tests=0 failures=0 errors=0 skipped=0 assertions=0 time=0 timestamp="$(date +%FT%T)" || return $?
}
_junitOpen() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Close tag for `testsuites`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitClose() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose testsuites "$@" || return $?
}
_junitClose() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Open tag for `testsuite`
# Example:     <testsuite name="Tests.Registration" tests="8" failures="1" errors="1" skipped="1"
# Example:          assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23"
# Example:          file="tests/registration.code">
#
# Attributes:
# - `name=Tests.Registration`
# - `tests=8`
# - `failures=1`
# - `errors=1`
# - `skipped=1`
# - `assertions=20`
# - `time=16.082687`
# - `timestamp=2021-04-02T15:48:23`
# - `file=tests/registration.code`
# Argument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitSuiteOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTag testsuite "$@" name || return $?
}
_junitSuiteOpen() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Close tag for `testsuite`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitSuiteClose() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose testsuite "$@" || return $?
}
_junitSuiteClose() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Full properties output. Properties are output depending on content containing a newline or not.
#
#  Example:     <properties>
#  Example:         <property name="version" value="1.774"/>
#  Example:         <property name="commit" value="ef7bebf"/>
#  Example:         <property name="browser" value="Google Chrome"/>
#  Example:         <property name="ci" value="https://github.com/actions/runs/1234"/>
#  Example:         <property name="config">
#  Example:             Config line #1
#  Example:             Config line #2
#  Example:             Config line #3
#  Example:         </property>
#  Example:     </properties>
junitProperties() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen properties || return $?
  junitPropertyList --handler "$handler" "$@" || return $?
  catchReturn "$handler" __xmlTagClose properties || return $?
}
_junitProperties() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Output list of `property` tags
# Argument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.
junitPropertyList() {
  local handler="_${FUNCNAME[0]}"
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *)
      local name value
      IFS="=" read -r name value <<<"$1" || :
      [ -n "$name" ] || continue
      if stringContains "$value" $'\n'; then
        catchReturn "$handler" __xmlTagOpen property name="$name" || return $?
        catchReturn "$handler" printf "%s\n" "$value" || return $?
        catchReturn "$handler" __xmlTagClose property || return $?
      else
        catchReturn "$handler" __xmlTag property name="$name" value="$value" || return $?
      fi
      ;;
    esac
    shift
  done
}
_junitPropertyList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Open tag for `system-out` - test output
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitSystemOutputOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen system-out || return $?
}
_junitSystemOutputOpen() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Close tag for `system-out` - test output
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitSystemOutputClose() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose system-out || return $?
}
_junitSystemOutputClose() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Open tag for `system-err` - test errors
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitSystemErrorOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen system-err || return $?
}
_junitSystemErrorOpen() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Close tag for `system-err` - test errors
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitSystemErrorClose() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose system-err || return $?
}
_junitSystemErrorClose() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Open tag for `testcase` - Test case
# Example:     <testcase name="testCase1" classname="Tests.Registration" assertions="2"
# Example:         time="2.436" file="tests/registration.code" line="24"/>
#
# - `name=testCase1`
# - `classname=Tests.Registration`
# - `assertions=2`
# - `time=2.436`
# - `file=tests/registration.code`
# - `line=24`
# Argument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitTestCaseOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen testcase "$@" || return $?
}
_junitTestCaseOpen() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Close tag for `testcase` - Test case
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitTestCaseClose() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose testcase || return $?
}
_junitTestCaseClose() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Output test skipped XML
# Argument: message - Why test was skipped.
junitTestCaseSkipped() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ $# -eq 0 ] || set -- message="$*"
  catchReturn "$handler" __xmlTag skipped "$@" || return $?
}
_junitTestCaseSkipped() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Open tag for `failure` - test failed
# Example:     <failure message="Expected value did not match." type="AssertionError">
# Example:         Failure description or stack trace
# Example:     </failure>
# Argument: message - Optional. String. Why failure occurred.
# Argument ... - String. Optional. Name/value tag attributes
# Attributes:
# - `type=AssertionError`
junitTestCaseFailureOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if [ $# -gt 0 ]; then
    local message && message="$(validate "$handler" String message "$1")" && shift || return $?
    set -- message="$message" "$@"
  fi
  catchReturn "$handler" __xmlTagOpen failure "$@" || return $?
}
_junitTestCaseFailureOpen() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Close tag for `failure` - test failed
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitTestCaseFailureClose() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose failure || return $?
}
_junitTestCaseFailureClose() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Open tag for `error` - test error output
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitTestCaseErrorOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if [ $# -gt 0 ]; then
    local message && message="$(validate "$handler" String message "$1")" && shift || return $?
    set -- message="$message" "$@"
  fi
  catchReturn "$handler" __xmlTagOpen error "$@" || return $?
}
_junitTestCaseErrorOpen() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Close tag for `error` - test error output
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
junitTestCaseErrorClose() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose error || return $?
}
_junitTestCaseErrorClose() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
