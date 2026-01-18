#!/usr/bin/env bash
#
# assert.sh
#
# Simple assert functions for testing
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: contextOpen ./documentation/source/tools/assert.md
# Test: contextOpen ./test/tools/assert-tests.sh

# Assert two strings are equal.
#
# If this fails it will output an error and exit.
#
# Argument: expected - String. Required. Expected string.
# Argument: actual - String. Required. Actual string
# Argument: message ... - String. Optional. Message to output if the assertion fails
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Example:     assertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"
# Reviewed: 2023-11-12
#
assertEquals() {
  _assertEqualsHelper "_${FUNCNAME[0]}" --success true "$@" || return $?
}
_assertEquals() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert a string is non-empty.
#
# If this fails it will output an error and exit.
#
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: string ... - Not empty strings
# Example:     assertStringNotEmpty "$string"
# Reviewed: 2023-11-12
#
assertStringNotEmpty() {
  _assertStringEmptyHelper "${FUNCNAME[0]}" --success false "$@" || return $?
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
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: string ... - Empty strings
# Example:     assertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"
# Reviewed: 2023-11-12
#
assertStringEmpty() {
  _assertStringEmptyHelper "${FUNCNAME[0]}" --success true "$@" || return $?
}
_assertStringEmpty() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert two strings are not equal.
#
# If this fails it will output an error and exit.
# Summary: Assert two strings are not equal
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: expected - String. Required. Expected string.
# Argument: actual - Required. Actual string.
# Argument: message - Message to output if the assertion fails. Optional.
# Example:     assertNotEquals "$(uname -s)" "FreeBSD" "Not compatible with FreeBSD"
# Example:     Single quote break-s
# Reviewed: 2023-11-12
assertNotEquals() {
  _assertEqualsHelper "_${FUNCNAME[0]}" --success false "$@" || return $?
}
_assertNotEquals() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert a process runs and exits with the correct exit code.
#
# If this fails it will output an error and exit.
#
# Argument: expectedExitCode - UnsignedInteger. Required. A numeric exit code expected from the command.
# Argument: command - Callable. Required. The command to run
# Argument: arguments - Arguments. Optional. Any arguments to pass to the command to run
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Examples:     assertExitCode 0 hasHook version-current
# Reviewed: 2023-11-12
# Return Code: 0 - If the process exits with the provided exit code
# Return Code: 1 - If the process exits with a different exit code
#
assertExitCode() {
  _assertExitCodeHelper "_${FUNCNAME[0]}" --success true "$@" || return $?
}
_assertExitCode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert a process runs and exits with an exit code which does not match the passed in exit code.
#
# If this fails it will output an error and exit.
#
# Argument: expectedExitCode - UnsignedInteger. A numeric exit code not expected from the command.
# Argument: command - Callable. The command to run
# Argument: arguments - Arguments. Optional. Any arguments to pass to the command to run
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Examples:     {fn} 0 hasHook make-cash-quickly
# Reviewed: 2023-11-12
# Return Code: 0 - If the process exits with a different exit code
# Return Code: 1 - If the process exits with the provided exit code
#
assertNotExitCode() {
  _assertExitCodeHelper "_${FUNCNAME[0]}" --success false "$@" || return $?
}
_assertNotExitCode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert one string contains another (case-sensitive)
#
# Argument: needle - String. Text we are looking for.
# Argument: haystack ... - String. One or more strings to find `needle` in - it must be found in all haystacks.
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - The assertion succeeded
# Return Code: 1 - Assertion failed
# Return Code: 2 - Bad arguments
#
assertContains() {
  _assertContainsHelper "_${FUNCNAME[0]}" --success true "$@" || return $?
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
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - The assertion succeeded
# Return Code: 1 - Assertion failed
# Return Code: 2 - Bad arguments
# See: assertContains
assertNotContains() {
  _assertContainsHelper "_${FUNCNAME[0]}" --success false "$@" || return $?
}
_assertNotContains() {
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
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `directory` is anything but a `directory`
# Example:     assertDirectoryExists "$HOME" "HOME not found"
assertDirectoryExists() {
  _assertDirectoryExistsHelper "_${FUNCNAME[0]}" "$@" || return $?
}
_assertDirectoryExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Required. Directory that should NOT exist
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `directory` is anything at all, even a non-directory (such as a link)
# Examples: assertDirectoryDoesNotExist "$INSTALL_PATH" "INSTALL_PATH should not exist yet"
# Summary: Test that a directory does not exist
# Reviewed: 2023-11-12
#
assertDirectoryDoesNotExist() {
  _assertDirectoryExistsHelper "_${FUNCNAME[0]}" --success false "$@" || return $?
}
_assertDirectoryDoesNotExist() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Directory that should exist and be empty
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `directory` is anything but a `directory`
# Example:     assertDirectoryExists "$HOME" "HOME not found"
# Summary: Test that a directory exists
#
assertDirectoryEmpty() {
  _assertDirectoryExistsHelper "_${FUNCNAME[0]}" "$@" || return $?
  _assertDirectoryEmptyHelper "_${FUNCNAME[0]}" "$@" || return $?
}
_assertDirectoryEmpty() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Directory that should exist and not be empty
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Examples: {fn} "$INSTALL_PATH" "INSTALL_PATH should contain files"
# Summary: Test that a directory does not exist
# Reviewed: 2023-11-12
#
assertDirectoryNotEmpty() {
  _assertDirectoryExistsHelper "_${FUNCNAME[0]}" "$@" || return $?
  _assertDirectoryEmptyHelper "_${FUNCNAME[0]}" --success false "$@" || return $?
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
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `file` is anything but a `file`
# Example:     assertDirectoryExists "$HOME" "HOME not found"
# Summary: Test that a file exists
#
assertFileExists() {
  _assertFileExistsHelper "_${FUNCNAME[0]}" "$@" || return $?
}
_assertFileExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: item - String. Required. File that should NOT exist
# Argument: message ... - String. Optional. An error message if this fails
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: - This fails if `file` is anything at all, even a non-file (such as a link)
# Examples: assertDirectoryDoesNotExist "$INSTALL_PATH" "INSTALL_PATH should not exist yet"
# Summary: Test that a file does not exist
# Reviewed: 2023-11-12
#
assertFileDoesNotExist() {
  _assertFileExistsHelper "_${FUNCNAME[0]}" --success false "$@" || return $?
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
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Example:     assertOutputEquals "2023" date +%Y
# Reviewed: 2023-11-12
#
assertOutputEquals() {
  _assertOutputEqualsHelper "_${FUNCNAME[0]}" "$@" || return $?
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
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the output contains at least one occurrence of the string
# Return Code: 1 - If output does not contain string
# Example:     {fn} Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
assertOutputContains() {
  _assertOutputContainsHelper "_${FUNCNAME[0]}" --success true "$@" || return $?
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
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the output contains at least one occurrence of the string
# Return Code: 1 - If output does not contain string
# Example:     assertOutputDoesNotContain Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
assertOutputDoesNotContain() {
  _assertOutputContainsHelper "_${FUNCNAME[0]}" --success false "$@" || return $?
}
_assertOutputDoesNotContain() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file contains one or more strings
# Argument: fileName - File. Required. File to search
# Argument: string ... - String. Required. One or more strings which must be found on at least one line in the file
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 0 - If the assertion succeeds
# Return Code: 1 - If the assertion fails
# Environment: If the file does not exist, this will fail.
# Example:     assertFileContains $logFile Success
# Example:     assertFileContains $logFile "is up to date"
# Reviewed: 2023-11-12
#
assertFileContains() {
  __assertFileContainsThis "_${FUNCNAME[0]}" --line-depth 2 "$@" || return $?
}
_assertFileContains() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file does not contains any occurrence of one or more strings
# Argument: fileName - File. Required. File to search
# Argument: string ... - String. Required. One or more strings which must NOT be found anywhere in `fileName`
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     assertFileDoesNotContain $logFile error Error ERROR
# Example:     assertFileDoesNotContain $logFile warning Warning WARNING
#
assertFileDoesNotContain() {
  __assertFileDoesNotContainThis "_${FUNCNAME[0]}" "$@" || return $?
}
_assertFileDoesNotContain() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file has an expected size in bytes
# Argument: expectedSize - PositiveInteger. Required. Integer file size which `fileName` should be, in bytes.
# Argument: fileName ... - File. Required. One ore more file which should be `expectedSize` bytes in size.
#
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertFileSize() {
  _assertFileSizeHelper "_${FUNCNAME[0]}" "$@" || return $?
}
_assertFileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file does NOT have an expected size in bytes
#
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: expectedSize - PositiveInteger. Required. Integer file size which `fileName` should NOT be, in bytes.
# Argument: fileName ... - File. Required. One ore more file which should NOT be `expectedSize` bytes in size.
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertNotFileSize() {
  _assertFileSizeHelper "_${FUNCNAME[0]}" --success false "$@" || return $?
}
_assertNotFileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file is empty (zero sized)
#
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: - fileName ... - File. Required. One ore more file which should be zero bytes in size.
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} .config
# Example:     {fn} /var/www/log/error.log
#
assertZeroFileSize() {
  assertFileSize 0 "$@" || return $?
}
_assertZeroFileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert a file is non-empty (non-zero sized)
#
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: - fileName ... - File. Required. One ore more file which should NOT be zero bytes in size.
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertNotZeroFileSize() {
  assertNotFileSize 0 "$@" || return $?
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
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: leftValue - Integer. Required. Value to compare on the left hand side of the comparison
# Argument: rightValue - Integer. Required. Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertGreaterThan 3 "$found"
# Reviewed: 2023-11-14
#
assertGreaterThan() {
  _assertNumericHelper "_${FUNCNAME[0]}" "$@" -gt || return $?
}
_assertGreaterThan() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert `leftValue >= rightValue`
#
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: leftValue - Integer. Required. Value to compare on the left hand side of the comparison
# Argument: rightValue - Integer. Required. Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertGreaterThanOrEqual 3 $found
# Reviewed: 2023-11-12
# Summary: Assert actual value is greater than or equal to expected value
assertGreaterThanOrEqual() {
  _assertNumericHelper "_${FUNCNAME[0]}" "$@" -ge || return $?
}
_assertGreaterThanOrEqual() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert `leftValue < rightValue`
#
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: leftValue - Integer. Required. Value to compare on the left hand side of the comparison
# Argument: rightValue - Integer. Required. Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertLessThan 3 $found
# Reviewed: 2023-11-12
# Return Code: 0 - expected less than to actual
# Return Code: 1 - expected greater than or equal to actual, or invalid numbers
assertLessThan() {
  _assertNumericHelper "_${FUNCNAME[0]}" "$@" -lt || return $?
}
_assertLessThan() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Assert `leftValue <= rightValue`
#
# DOC TEMPLATE: assert-common 18
# Argument: --help - Flag. Optional. Display this help.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - String. Optional. Display name for the condition.
# Argument: --success - Boolean. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - String. Optional. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls.
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# Argument: leftValue - Integer. Required. Value to compare on the left hand side of the comparison
# Argument: rightValue - Integer. Required. Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertLessThanOrEqual 3 $found
# Reviewed: 2023-11-12
# Return Code: 0 - expected less than or equal to actual
# Return Code: 1 - expected greater than actual, or invalid numbers
#
assertLessThanOrEqual() {
  _assertNumericHelper "_${FUNCNAME[0]}" "$@" -le || return $?
}
_assertLessThanOrEqual() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
