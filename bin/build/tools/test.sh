#!/usr/bin/env bash
#
# test.sh
#
# Test support functions
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#   _            _
#  | |_ _____  _| |_
#  | __/ _ \ \/ / __|
#  | ||  __/>  <| |_
#   \__\___/_/\_\\__|
#

__testLoader() {
  __buildFunctionLoader __testSuite test "$@"
}

# Run bash test suites for {name}.
#
# Supports argument flags in tests:
# `TAP-Directive` `Test-Skip` `TODO`
#
# You can also use `BUILD_TEST_FLAGS` to change the default flags.
#
# #### Tag filters
#
# Prefix a tag with `+` for `--tag` or `--skip-tag` queries to add the meaning "previous *AND*".
#
# - `--tag foo --tag bar` means tests must have `foo` tag OR must have `bar` tag
# - `--tag foo --tag +bar` means tests must have `foo` tag AND must have `bar` tag (must have both)
# - `--skip-tag foo --skip-tag bar` means skip any test with `foo` tag OR with any test with `bar` tag (either)
# - `--skip-tag foo --skip-tag +bar` means skip any test with `foo` tag AND with the `bar` tag (must have both)
# - `--tag a --tag +b --tag c --tag +d --tag +e` is `(a and b) or (c and d and e)`
#
# Notes: Consider using `--tag a+b --tag c+d+e` instead? TODO
#
# Your test functions can contain tags as follows:
#
#     # Tag: tagA tagB
#     # Tag: tagC
#     # Test-Platform: !alpine alpine !linux linux !darwin darwin
#     # Test-Skip: true
#     # Test-Housekeeper: false
#     # Test-Plumber: true
#     # Test-TAP-Directive: Something
#     # Test-After: testWhichShouldGoBefore
#     # Test-Before: testWhichShouldGoAfter
#     # Test-Fail: true
#     testThingy() {
#        ...
#     }
#
# Environment variables:
#
# - `BUILD_TEST_FLAGS` - SemicolonDelimitedList. Add flags like 'Plumber:false' to disable settings across tests.
# - `BUILD_DEBUG` - Many settings to debug different systems, comma-delimited.
#
# Environment: BUILD_TEST_FLAGS BUILD_DEBUG
# Filters (`--tag` and `--skip-tag`) are applied in order after the function pattern or suite filter.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --clean - Flag. Optional. Delete test artifact files and exit. (No tests run)
# Argument: -l | --list - Flag. Optional. List all test names (which match if applicable).
# Argument: --env-file environmentFile - EnvironmentFile. Optional. Load one ore more environment files prior to running tests
# Argument: --index-file indexFile - RealDirectoryFile. Optional. If supplied and exists, uses the index file for tests.
# Argument: --cache-path cachePath - Directory. Optional.
# Argument: --make-index - Flag. Optional. Generate the index file if supplied and quit.
# Argument: --continue - Flag. Optional. Continue from last successful test.
# Argument: -c - Flag. Optional. Continue from last successful test.
# Argument: --delete directoryOrFile - FileDirectory. Optional. A file or directory to delete when the test suite terminates.
# Argument: --delete-common - Flag. Delete `./vendor` and `./node_modules` (and other temporary build directories) by default.
# Argument: --debug - Flag. Optional. Enable debugging for `--junit` (saves caches).
# Argument: --verbose - Flag. Optional. Be verbose.
# Argument: --stop - Flag. Optional. Stop after a failure instead of attempting to continue.
# Argument: --coverage - Flag. Optional. Feature in progress - generate a coverage file for tests.
# Argument: --no-stats - Flag. Optional. Do not generate a test.stats file showing test timings when completed.
# Argument: --messy - Flag. Optional. Do not delete test artifact files afterwards.
# Argument: --fail executor - Callable. Optional. One or more programs to run on the failed test files. Takes arguments: testName testFile testLine
# Argument: --cd-away - Flag. Optional. Change directories to a temporary directory before each test.
# Argument: --tap tapFile - FileDirectory. Optional. Output test results in TAP format to `tapFile`.
# Argument: --junit junitFile - FileDirectory. Optional. Output test results in junit format to `junitFile`. If a directory is specified the output is to `junit.xml`.
# Argument: --show | --suites - Flag. Optional. List all test suites.
# Argument: -1 | --suite | --one testSuite - String. Optional. Add one test suite to run.
# Argument: --tag tagName - String. Optional. Include tests (only) tagged with this name.
# Argument: --list-tags | --tags | --show-tags - Flag. Optional. Of the matched tests, display the tags that they have, if any. Unique list.
# Argument: --skip-tag tagName - String. Optional. Skip tests tagged with this name.
# Argument: testFunctionPattern ... - String. Optional. Test function (or substring of function name) to run.
# Hook: tests-start
# Hook: test-start
# Hook: test-pass
# Hook: test-fail
# Hook: tests-stop
# Requires: head tee printf trap
# Requires: decorate loadAverage consoleConfigureColorMode
# Requires: buildEnvironmentLoad usageArgumentString catchEnvironment
# Requires: bashCoverage
# BUILD_DEBUG: test-dump-environment - When set tests will dump the environment at the end.
testSuite() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_testSuite() {
  local defaultName && defaultName=$(buildEnvironmentGet APPLICATION_NAME 2>/dev/null) || defaultName="any product"
  fn="${fn-"${FUNCNAME[0]#_}"}" name=${name-"$defaultName"} usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Output assertion counts
# Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline
# Argument: --reset - Flag. Optional. Reset statistics to zero.
# Argument: --total - Flag. Optional. Just output the total.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# stdout: UnsignedInteger. 2 lines.
# Example:     read -r failures successes < <({fn}) || return $?
assertStatistics() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_assertStatistics() {
  true || assertStatistics --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a process runs and exits with the correct exit code.
#
# If this fails it will output an error and exit.
#
# Argument: expectedExitCode - UnsignedInteger. Required. A numeric exit code expected from the command.
# Argument: command - Callable. Required. The command to run
# Argument: arguments - Arguments. Optional. Any arguments to pass to the command to run
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Examples:     assertExitCode 0 hookExists version-current
# Reviewed: 2023-11-12
# Return Code: 0 - If the process exits with the provided exit code
# Return Code: 1 - If the process exits with a different exit code
#
assertExitCode() {
  __testLoader "_${FUNCNAME[0]}" _assertExitCodeHelper --success true "$@" || return $?
}
_assertExitCode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a process runs and exits with an exit code which does not match the passed in exit code.
#
# If this fails it will output an error and exit.
#
# Argument: expectedExitCode - UnsignedInteger. A numeric exit code not expected from the command.
# Argument: command - Callable. The command to run
# Argument: arguments - Arguments. Optional. Any arguments to pass to the command to run
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Examples:     {fn} 0 hookExists make-cash-quickly
# Reviewed: 2023-11-12
# Return Code: 0 - If the process exits with a different exit code
# Return Code: 1 - If the process exits with the provided exit code
#
assertNotExitCode() {
  __testLoader "_${FUNCNAME[0]}" _assertExitCodeHelper --success false "$@" || return $?
}
_assertNotExitCode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert two strings are equal.
#
# If this fails it will output an error and exit.
#
# Argument: expected - String. Required. Expected string.
# Argument: actual - String. Required. Actual string
# Argument: message ... - String. Optional. Message to output if the assertion fails
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Example:     assertEquals "$(textAlignRight 4 "hi")" "  hi" "textAlignRight not working"
# Reviewed: 2023-11-12
#
assertEquals() {
  __testLoader "_${FUNCNAME[0]}" _assertEqualsHelper --success true "$@" || return $?
}
_assertEquals() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert two strings are not equal.
#
# If this fails it will output an error and exit.
# Summary: Assert two strings are not equal
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: expected - String. Required. Expected string.
# Argument: actual - Required. Actual string.
# Argument: message - Message to output if the assertion fails. Optional.
# Example:     assertNotEquals "$(uname -s)" "FreeBSD" "Not compatible with FreeBSD"
# Example:     Single quote break-s
# Reviewed: 2023-11-12
assertNotEquals() {
  __testLoader "_${FUNCNAME[0]}" _assertEqualsHelper --success false "$@" || return $?
}
_assertNotEquals() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a string is non-empty.
#
# If this fails it will output an error and exit.
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: string ... - Not empty strings
# Example:     assertStringNotEmpty "$string"
# Reviewed: 2023-11-12
#
assertStringNotEmpty() {
  __testLoader "_${FUNCNAME[0]}" _assertStringEmptyHelper --success false "$@" || return $?
}
_assertStringNotEmpty() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert a string is empty.
#
# If this fails it will output an error and exit.
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: string ... - Empty strings
# Example:     assertEquals "$(textAlignRight 4 "hi")" "  hi" "textAlignRight not working"
# Reviewed: 2023-11-12
#
assertStringEmpty() {
  __testLoader "_${FUNCNAME[0]}" _assertStringEmptyHelper --success true "$@" || return $?
}
_assertStringEmpty() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert one string contains another (case-sensitive)
#
# Argument: needle - String. Text we are looking for.
# Argument: haystack ... - String. One or more strings to find `needle` in - it must be found in all haystacks.
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - The assertion succeeded
# Return Code: 1 - Assertion failed
# Return Code: 2 - Bad arguments
#
assertContains() {
  __testLoader "_${FUNCNAME[0]}" _assertContainsHelper --success true "$@" || return $?
}
_assertContains() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert one string does not contains another (case-sensitive)
#
# Argument: needle - String. Text we are looking for.
# Argument: haystack ... - String. One or more strings to find `needle` in - it must be found in no haystacks.
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - The assertion succeeded
# Return Code: 1 - Assertion failed
# Return Code: 2 - Bad arguments
# See: assertContains
assertNotContains() {
  __testLoader "_${FUNCNAME[0]}" _assertContainsHelper --success false "$@" || return $?
}
_assertNotContains() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: --cache cacheDirectory - Directory. Optional. Cache directory to use for ordering work.
# Argument: finderFile - File. Required. File to reorder.
# stdout: Reordered file.
testSuiteOrdering() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_testSuiteOrdering() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# DOC TEMPLATE: --help 1
# Summary: Was a function tested already?
# When environment variable `TEST_TRACK_ASSERTIONS` is `true` – `testSuite` and assertion functions track which functions take a function value (for example, `assertExitCode`) and track functions which are run, and stores them in the testing cache directory which accumulate after each test run unless the cache is cleared.
# Argument: --help - Flag. Optional. Display this help.
# Argument: --verbose - Flag. Optional. Show list of true results when all arguments pass.
# Argument: functionName ... - String. Function to look up to see if it has been tested. One or more.
# Return Code: 0 - All functions were tested by the test suite at least once.
# Return Code: 1 - At least one function was not tested by the test suite at least once.
# Important: If you test your function's `--help` function then you can ignore it using
# Environment: TEST_TRACK_ASSERTIONS
testSuiteFunctionTested() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_testSuiteFunctionTested() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

################################################################################################################################
#
# ▛▀▖▗          ▐
# ▌ ▌▄ ▙▀▖▞▀▖▞▀▖▜▀ ▞▀▖▙▀▖▌ ▌
# ▌ ▌▐ ▌  ▛▀ ▌ ▖▐ ▖▌ ▌▌  ▚▄▌
# ▀▀ ▀▘▘  ▝▀▘▝▀  ▀ ▝▀ ▘  ▗▄▘
#

# Summary: Test that a directory exists
# Argument: directory - Directory. Required. Directory that should exist
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `directory` is anything but a `directory`
# Example:     assertDirectoryExists "$HOME" "HOME not found"
assertDirectoryExists() {
  __testLoader "_${FUNCNAME[0]}" _assertDirectoryExistsHelper "$@" || return $?
}
_assertDirectoryExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Required. Directory that should NOT exist
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `directory` is anything at all, even a non-directory (such as a link)
# Examples: assertDirectoryDoesNotExist "$INSTALL_PATH" "INSTALL_PATH should not exist yet"
# Summary: Test that a directory does not exist
# Reviewed: 2023-11-12
#
assertDirectoryDoesNotExist() {
  __testLoader "_${FUNCNAME[0]}" _assertDirectoryExistsHelper --success false "$@" || return $?
}
_assertDirectoryDoesNotExist() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Directory that should exist and be empty
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `directory` is anything but a `directory`
# Example:     assertDirectoryExists "$HOME" "HOME not found"
# Summary: Test that a directory exists
#
assertDirectoryEmpty() {
  local handler="_${FUNCNAME[0]}"

  __testLoader "$handler" _assertDirectoryExistsHelper "$@" || return $?
  __testLoader "$handler" _assertDirectoryEmptyHelper "$@" || return $?
}
_assertDirectoryEmpty() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Directory that should exist and not be empty
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Examples: {fn} "$INSTALL_PATH" "INSTALL_PATH should contain files"
# Summary: Test that a directory does not exist
# Reviewed: 2023-11-12
#
assertDirectoryNotEmpty() {
  local handler="_${FUNCNAME[0]}"
  __testLoader "$handler" _assertDirectoryExistsHelper "$@" || return $?
  __testLoader "$handler" _assertDirectoryEmptyHelper --success false "$@" || return $?
}
_assertDirectoryNotEmpty() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

################################################################################################################################
#
# ▛▀▘▗▜
# ▙▄ ▄▐ ▞▀▖
# ▌  ▐▐ ▛▀
# ▘  ▀▘▘▝▀▘
#

# Argument: item - File. Required. File that should exist
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `file` is anything but a `file`
# Example:     assertDirectoryExists "$HOME" "HOME not found"
# Summary: Test that a file exists
#
assertFileExists() {
  __testLoader "_${FUNCNAME[0]}" _assertFileExistsHelper "$@" || return $?
}
_assertFileExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: item - String. Required. File that should NOT exist
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `file` is anything at all, even a non-file (such as a link)
# Examples: assertDirectoryDoesNotExist "$INSTALL_PATH" "INSTALL_PATH should not exist yet"
# Summary: Test that a file does not exist
# Reviewed: 2023-11-12
#
assertFileDoesNotExist() {
  __testLoader "_${FUNCNAME[0]}" _assertFileExistsHelper --success false "$@" || return $?
}
_assertFileDoesNotExist() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

################################################################################################################################
#
# ▞▀▖   ▐        ▐
# ▌ ▌▌ ▌▜▀ ▛▀▖▌ ▌▜▀
# ▌ ▌▌ ▌▐ ▖▙▄▘▌ ▌▐ ▖
# ▝▀ ▝▀▘ ▀ ▌  ▝▀▘ ▀

#
# Assert output of a binary equals a string
#
# If this fails it will output an error and exit.
#
# Argument: expected - EmptyString. Expected string to match output.
# Argument: binary - Callable. Required. Binary to run and evaluate output
# Argument: ... - Arguments. Optional. Any additional arguments to `binary`.
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Example:     assertOutputEquals "2023" date +%Y
# Reviewed: 2023-11-12
#
assertOutputEquals() {
  __testLoader "_${FUNCNAME[0]}" _assertOutputEqualsHelper "$@" || return $?
}
_assertOutputEquals() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Run a command and expect the output to contain the occurrence of a string.
#
# If this fails it will output the command result to stdout.
# Argument: expected - String. Required. A string to expect in the output
# Argument: binary - Callable. Required. Binary to run and evaluate output
# Argument: ... - Arguments. Optional. Any additional arguments to `binary`.
# Argument: --exit - Assert exit status of process to be this number
# Argument: --stderr - Also include standard error in output checking
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the output contains at least one occurrence of the string
# Return Code: 1 - If output does not contain string
# Example:     {fn} Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
assertOutputContains() {
  __testLoader "_${FUNCNAME[0]}" _assertOutputContainsHelper --success true "$@" || return $?
}
_assertOutputContains() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Run a command and expect the output to not contain the occurrence of a string.
#
# If this fails it will output the command result to stdout.
#
# Argument: expected - String. Required. A string NOT to expect in the output
# Argument: binary - Callable. Required. Binary to run and evaluate output
# Argument: ... - Arguments. Optional. Any additional arguments to `binary`.
# Argument: --exit - Assert exit status of process to be this number
# Argument: --stderr - Also include standard error in output checking
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the output contains at least one occurrence of the string
# Return Code: 1 - If output does not contain string
# Example:     assertOutputDoesNotContain Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
assertOutputDoesNotContain() {
  __testLoader "_${FUNCNAME[0]}" _assertOutputContainsHelper --success false "$@" || return $?
}
_assertOutputDoesNotContain() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file contains one or more strings
# Argument: fileName - File. Required. File to search
# Argument: string ... - String. Required. One or more strings which must be found on at least one line in the file
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: If the file does not exist, this will fail.
# Example:     assertFileContains $logFile Success
# Example:     assertFileContains $logFile "is up to date"
# Reviewed: 2023-11-12
#
assertFileContains() {
  __testLoader "_${FUNCNAME[0]}" __assertFileContainsHelper true false --line-depth 5 "$@" || return $?
}
_assertFileContains() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file does not contains any occurrence of one or more strings
# Argument: fileName - File. Required. File to search
# Argument: string ... - String. Required. One or more strings which must NOT be found anywhere in `fileName`
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     assertFileDoesNotContain $logFile error Error ERROR
# Example:     assertFileDoesNotContain $logFile warning Warning WARNING
#
assertFileDoesNotContain() {
  __testLoader "_${FUNCNAME[0]}" __assertFileContainsHelper false false --line-depth 5 "$@" || return $?
}
_assertFileDoesNotContain() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file has an expected size in bytes
# Argument: expectedSize - PositiveInteger. Required. Integer file size which `fileName` should be, in bytes.
# Argument: fileName ... - File. Required. One ore more file which should be `expectedSize` bytes in size.
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertFileSize() {
  __testLoader "_${FUNCNAME[0]}" _assertFileSizeHelper "$@" || return $?
}
_assertFileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file does NOT have an expected size in bytes
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: expectedSize - PositiveInteger. Required. Integer file size which `fileName` should NOT be, in bytes.
# Argument: fileName ... - File. Required. One ore more file which should NOT be `expectedSize` bytes in size.
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertNotFileSize() {
  __testLoader "_${FUNCNAME[0]}" _assertFileSizeHelper --success false "$@" || return $?
}
_assertNotFileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file is empty (zero sized)
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: - fileName ... - File. Required. One ore more file which should be zero bytes in size.
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} .config
# Example:     {fn} /var/www/log/error.log
#
assertZeroFileSize() {
  # IDENTICAL faConsumeFlagArguments 4
  local fa=() && while [ $# -gt 0 ]; do
    case "$1" in -*) fa+=("$1") ;; *) break ;; esac
    shift
  done
  __testLoader "_${FUNCNAME[0]}" _assertFileSizeHelper "${fa[@]+"${fa[@]}"}" 0 "$@" || return $?
}
_assertZeroFileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file is non-empty (non-zero sized)
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: - fileName ... - File. Required. One ore more file which should NOT be zero bytes in size.
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertNotZeroFileSize() {
  # IDENTICAL faConsumeFlagArguments 4
  local fa=() && while [ $# -gt 0 ]; do
    case "$1" in -*) fa+=("$1") ;; *) break ;; esac
    shift
  done
  __testLoader "_${FUNCNAME[0]}" _assertFileSizeHelper --success false "${fa[@]+"${fa[@]}"}" 0 "$@" || return $?
}
_assertNotZeroFileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

################################################################################################################################
#
# ▙ ▌             ▗     ▞▀▖                ▗
# ▌▌▌▌ ▌▛▚▀▖▞▀▖▙▀▖▄ ▞▀▖ ▌  ▞▀▖▛▚▀▖▛▀▖▝▀▖▙▀▖▄ ▞▀▘▞▀▖▛▀▖
# ▌▝▌▌ ▌▌▐ ▌▛▀ ▌  ▐ ▌ ▖ ▌ ▖▌ ▌▌▐ ▌▙▄▘▞▀▌▌  ▐ ▝▀▖▌ ▌▌ ▌
# ▘ ▘▝▀▘▘▝ ▘▝▀▘▘  ▀▘▝▀  ▝▀ ▝▀ ▘▝ ▘▌  ▝▀▘▘  ▀▘▀▀ ▝▀ ▘ ▘
#

#
# Assert `leftValue > rightValue`
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: leftValue - Integer. Required. Value to compare on the left hand side of the comparison
# Argument: rightValue - Integer. Required. Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertGreaterThan 3 "$found"
# Reviewed: 2023-11-14
#
assertGreaterThan() {
  __testLoader "_${FUNCNAME[0]}" _assertNumericHelper "$@" -gt || return $?
}
_assertGreaterThan() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert `leftValue >= rightValue`
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: leftValue - Integer. Required. Value to compare on the left hand side of the comparison
# Argument: rightValue - Integer. Required. Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertGreaterThanOrEqual 3 $found
# Reviewed: 2023-11-12
# Summary: Assert actual value is greater than or equal to expected value
assertGreaterThanOrEqual() {
  __testLoader "_${FUNCNAME[0]}" _assertNumericHelper "$@" -ge || return $?
}
_assertGreaterThanOrEqual() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert `leftValue < rightValue`
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: leftValue - Integer. Required. Value to compare on the left hand side of the comparison
# Argument: rightValue - Integer. Required. Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertLessThan 3 $found
# Reviewed: 2023-11-12
# Return Code: 0 - expected less than to actual
# Return Code: 1 - expected greater than or equal to actual, or invalid numbers
assertLessThan() {
  __testLoader "_${FUNCNAME[0]}" _assertNumericHelper "$@" -lt || return $?
}
_assertLessThan() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert `leftValue <= rightValue`
#
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Argument: leftValue - Integer. Required. Value to compare on the left hand side of the comparison
# Argument: rightValue - Integer. Required. Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertLessThanOrEqual 3 $found
# Reviewed: 2026-02-02
# Return Code: 0 - expected less than or equal to actual
# Return Code: 1 - expected greater than actual, or invalid numbers
#
assertLessThanOrEqual() {
  __testLoader "_${FUNCNAME[0]}" _assertNumericHelper "$@" -le || return $?
}
_assertLessThanOrEqual() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fake a value for testing
# Argument: globalName - EnvironmentVariable. Required. Global to change temporarily to a value.
# Argument: value - EmptyString. Optional. Force the value of `globalName` to this value temporarily. Saves the original value.
# Argument: ... - Continue passing pairs of globalName value to mock additional values.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
mockEnvironmentStart() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_mockEnvironmentStart() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Restore a mocked value. Works solely with the default `saveGlobalName` (e.g. `__MOCK_${globalName}`).
# Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
mockEnvironmentStop() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_mockEnvironmentStop() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fake `consoleHasAnimation` for testing
# Argument: true | false - Boolean. Force the value of consoleHasAnimation to this value temporarily. Saves the original value.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
mockConsoleAnimationStart() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_mockConsoleAnimationStart() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Stop faking `consoleHasAnimation` for testing
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
mockConsoleAnimationStop() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_mockConsoleAnimationStop() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL returnAssert 13

# Return code is `assert`
# Summary: Assertion return code
# Return Code: 97
returnAssert() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnAssertCode 1
  return 97 # "$(returnCode assert)"
}
_returnAssert() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL returnIdentical 13

# Summary: Identical return code
# Return code is `identical`
# Return Code: 105
returnIdentical() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnIdenticalCode 1
  return 105 # "$(returnCode identical)"
}
_returnIdentical() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL returnLeak 13

# Summary: Leak return code
# Return code is `leak`
# Return Code: 108
returnLeak() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # _IDENTICAL_ returnLeakCode 1
  return 108 # "$(returnCode leak)"
}
_returnLeak() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
