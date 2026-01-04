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
junitOpen() {
  __xmlTagOpen testsuites "$@" name="" tests=0 failures=0 errors=0 skipped=0 assertions=0 time=0 timestamp="$(date +%FT%T)"
}

# Close tag for `testsuites`
junitClose() {
  __xmlTagClose testsuites
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
junitSuiteOpen() {
  __xmlTag testsuite "$@" name
}

# Close tag for `testsuite`
junitSuiteClose() {
  __xmlTagClose testsuite
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
  __xmlTagOpen properties
  junitPropertyList "$@"
  __xmlTagClose properties
}

# Output list of `property` tags
# Argument: nameValue ... - Optional. A list of name value pairs (unquoted) to output as XML `property` tags.
junitPropertyList() {
  while [ $# -gt 0 ]; do
    local name value
    IFS="=" read -r name value <<<"$1" || :
    [ -n "$name" ] || continue
    if stringContains "$value" $'\n'; then
      __xmlTagOpen property name="$name"
      printf "%s\n" "$value"
      __xmlTagClose property
    else
      __xmlTag property name="$name" value="$value"
    fi
    shift
  done
}

# Open tag for `system-out` - test output
junitSystemOutputOpen() {
  __xmlTagOpen system-out
}

# Close tag for `system-out` - test output
junitSystemOutputClose() {
  __xmlCLose system-out
}

# Open tag for `system-err` - test errors
junitSystemErrorOpen() {
  __xmlTagOpen system-err
}

# Close tag for `system-err` - test errors
junitSystemErrorClose() {
  __xmlCLose system-err
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
junitTestCaseOpen() {
  __xmlTagOpen testcase "$@"
}

# Close tag for `testcase` - Test case
junitTestCaseClose() {
  __xmlClsoe testcase
}

# Argument: message - Why test was skipped.
junitTestCaseSkipped() {
  __xmlTag skipped message="$*"
}

# Open tag for `failure` - test failed
# Example:     <failure message="Expected value did not match." type="AssertionError">
# Example:         Failure description or stack trace
# Example:     </failure>
# Argument: message - Required. Why failure occurred.
# Argument ... - Optional. String. failure description.
# Attributes:
# - `type=AssertionError`
junitTestCaseFailedOpen() {
  local message="$1" && shift
  __xmlTagOpen failure message="$message" "$@"
}

# Close tag for `failure` - test failed
junitTestCaseFailedClose() {
  __xmlCLose failure
}

# Open tag for `error` - test error output
junitTestCaseErrorOpen() {
  local message="$1" && shift
  __xmlTagOpen error message="$message" "$@"
}

# Close tag for `error` - test error output
junitTestCaseErrorClose() {
  __xmlCLose error
}
