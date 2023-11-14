#!/usr/bin/env bash
#
# assert.sh
#
# Simple assert functions for testing
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh text.sh prefixLines
#
# TODO md5sum is not portable
#

errorEnvironment=1

# Assert two strings are equal.
#
# If this fails it will output an error and exit.
#
# Usage: assertEquals expected actual [ message ]
# Argument: - `expected` - Expected string
# Argument: - `actual` - Actual string
# Argument: - `message` - Message to output if the assertion fails
# Example: assertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"
# Reviewed: 2023-11-12
#
assertEquals() {
    local a=$1 b=$2
    shift
    shift
    if [ "$a" != "$b" ]; then
        consoleError "assertEquals $a != $b but should: $*"
        exit "$errorEnvironment"
    else
        consoleSuccess "assertEquals $a == $b (correct)"
    fi
}
# Assert two strings are not equal.
#
# If this fails it will output an error and exit.
# Usage: assertNotEquals expected actual [ message ]
# Argument: - `expected` - Expected string
# Argument: - `actual` - Actual string
# Argument: - `message` - Message to output if the assertion fails
# Example: assertNotEquals "$(head -1 /proc/1/sched | awk '{ print $1 })" "init" "sched should not be init"
# Reviewed: 2023-11-12
#
assertNotEquals() {
    local expected=$1 actual=$2
    shift
    shift
    if [ "$expected" = "$actual" ]; then
        consoleError "assertNotEquals $expected = $actual but should not: $*"
        exit $errorEnvironment
    else
        consoleSuccess "assertNotEquals $expected != $actual (correct)"
    fi
}

#
# Assert actual value is greater than expected value.
#
#     expected < actual will pass
#
# If this fails it will output an error and exit.
#
# Usage: assertGreaterThan expected actual [ message ]
# Argument: - `expected` - Expected numeric value
# Argument: - `actual` - Actual numeric value
# Argument: - `message` - Message to output if the assertion fails
# Example: assertGreaterThan 3 $found
# Reviewed: 2023-11-14
#
assertGreaterThan() {
    local expected=$1 actual=$2
    shift
    shift
    if [ "$actual" -gt "$expected" ]; then
        consoleSuccess "assertGreaterThan $actual -gt $expected (correct)"
    else
        consoleError "assertEquals $a != $b but should: $*"
        exit "$errorEnvironment"
    fi
}
# Assert actual value is greater than or equal to expected value.
#
# If this fails it will output an error and exit.
# Usage: assertNotEquals expected actual [ message ]
# Argument: - `expected` - Expected numeric value
# Argument: - `actual` - Actual numeric value
# Argument: - `message` - Message to output if the assertion fails
# Example: assertGreaterThanOrEqual 3 $found
# Reviewed: 2023-11-12
#
assertGreaterThanOrEqual() {
    local expected=$1 actual=$2
    shift
    shift
    if [ "$actual" -ge "$expected" ]; then
        consoleSuccess "assertGreaterThanOrEqual $actual -gt $expected (correct)"
    else
        consoleError "assertEquals $a != $b but should: $*"
        exit "$errorEnvironment"
    fi
}

# Assert actual value is greater than or equal to expected value.
#
# If this fails it will output an error and exit.
# Usage: assertLessThan expected actual [ message ]
# Argument: - `expected` - Expected numeric value
# Argument: - `actual` - Actual numeric value
# Argument: - `message` - Message to output if the assertion fails
# Example: assertLessThan 3 $found
# Reviewed: 2023-11-12
#
assertLessThan() {
    local expected=$1 actual=$2
    shift
    shift
    if [ "$actual" -ge "$expected" ]; then
        consoleSuccess "assertGreaterThan $actual -gt $expected (correct)"
    else
        consoleError "assertEquals $a != $b but should: $*"
        exit "$errorEnvironment"
    fi
}

# Assert two strings are not equal.
#
# If this fails it will output an error and exit.
# Usage: assertNotEquals expected actual [ message ]
# Argument: - `expected` - Expected numeric value
# Argument: - `actual` - Actual numeric value
# Argument: - `message` - Message to output if the assertion fails
# Example: assertLessThanOrEqual 3 $found
# Reviewed: 2023-11-12
#
assertLessThanOrEqual() {
    local expected=$1 actual=$2
    shift
    shift
    if [ "$expected" = "$actual" ]; then
        consoleError "assertNotEquals $expected = $actual but should not: $*"
        exit $errorEnvironment
    else
        consoleSuccess "assertNotEquals $expected != $actual (correct)"
    fi
}

#
# Assert a process runs and exits with the correct exit code.
#
# If this fails it will output an error and exit.
#
# Usage: assertExitCode expectedExitCode command [ arguments ... ]
#
# Argument: - `expectedExitCode` - A numeric exit code expected from the command
# Argument: - `command` - The command to run
# Argument: - `arguments` - Any arguments to pass to the command to run
# Local cache: None.
# Environment: None.
# Examples: assertExitCode 0 hasHook version-current
# Reviewed: 2023-11-12
#
assertExitCode() {
    local expected=$1 actual bin=$2

    shift
    shift
    actual=$(
        "$bin" "$@"
        echo "$?"
    )
    assertEquals "$actual" "$expected" "$* exit code should equal expected $expected ($actual)"
}

#
# Assert a process runs and exits with an exit code which does not match the passed in exit code.
#
# If this fails it will output an error and exit.
#
# Usage: assertNotExitCode expectedExitCode command [ arguments ... ]
# Argument: - `expectedExitCode` - A numeric exit code not expected from the command
# Argument: - `command` - The command to run
# Argument: - `arguments` - Any arguments to pass to the command to run
# Local cache: None
# Environment: None
# Examples: assertNotExitCode 0 hasHook make-cash-quickly
# Reviewed: 2023-11-12
#
assertNotExitCode() {
    local expected=$1 actual bin=$2

    shift
    shift
    set +e
    actual=$(
        "$bin" "$@"
        echo "$?"
    )
    set -e
    assertNotEquals "$expected" "$actual" "$* exit code should not equal expected $expected ($actual)"
}
#
# Run a command and expect the output to contain the occurrence of a string.
#
# If this fails it will output the command result to stdout.
#
# Usage: assertOutputContains expected command [ arguments ... ]
# Argument: - `expected` - A string to expect in the output
# Argument: - `command` - The command to run
# Argument: - `arguments` - Any arguments to pass to the command to run
# Exit code: 0 - If the output contains at least one occurrence of the string
# Exit code: 1 - If output does not contain string
# Local cache: None
# Example: assertOutputContains Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
assertOutputContains() {
    local expected=$1 tempFile

    shift
    tempFile=$(mktemp)
    actual=$(
        "$@" >"$tempFile"
        echo $?
    )
    assertEquals 0 "$actual" "Exit code should be zero"
    if grep -q "$expected" "$tempFile"; then
        consoleSuccess "$expected found in $* output"
    else
        consoleError "$expected not found in $* output"
        prefixLines "$(consoleCode)" <"$tempFile"
        consoleError "$(echoBar)"
        return 1
    fi
}

#
# Usage: randomString
# Output: 64 random hexadecimal characters
# Example: token=$(randomString)
#
randomString() {
    head --bytes=64 /dev/random | md5sum | cut -f 1 -d ' '
}
#
# Usage: assertDirectoryExists directory [ message ... ]
#
# Argument: - `directory` - Directory that should exist
# Argument: - `message` - An error message if this fails
# Exit code: - `0` - If the assertion succeeds
# Exit code: - `1` - If the assertion fails
# Local cache: None
# Environment: - This fails if `directory` is anything but a `directory`
# Example: assertDirectoryExists "$HOME" "HOME not found"
# Short Description: Test that a directory exists
#
assertDirectoryExists() {
    local d=$1

    shift
    if [ ! -d "$d" ]; then
        consoleError "$d was expected to not a directory but is NOT: $*"
        return 1
    fi
}
#
# Usage: assertDirectoryDoesNotExist directory [ message ... ]
#
# Argument: - `directory` - Directory that should NOT exist
# Argument: - `message` - An error message if this fails
# Exit code: - `0` - If the assertion succeeds
# Exit code: - `1` - If the assertion fails
# Local cache: None
# Environment: - This fails if `directory` is anything at all, even a non-directory (such as a link)
# Examples:     assertDirectoryDoesNotExists "$INSTALL_PATH" "INSTALL_PATH should not exist yet"
# Short Description: Test that a directory does not exist
# Reviewed: 2023-11-12
#
assertDirectoryDoesNotExist() {
    local d=$1

    shift
    if [ -d "$d" ]; then
        consoleError "$d was expected to not be a directory but is: $*"
        return 1
    fi
}

# Usage: assertFileContains fileName string0 [ ... ]
#
# Argument: - `fileName` - File to search
# Argument: - `string0 ...` - One or more strings which must be found on at least one line in the file
#
# Exit code: - `0` - If the assertion succeeds
# Exit code: - `1` - If the assertion fails
# Local cache: None
# Environment: If the file does not exist, this will fail.
# Example: assertFileContains $logFile Success
# Example: assertFileContains $logFile "is up to date"
# Reviewed: 2023-11-12
#
assertFileContains() {
    local f=$1

    shift
    if [ ! -f "$f" ]; then
        consoleError "assertFileContains: $f is not a file: $*"
    fi
    while [ $# -gt 0 ]; do
        if ! grep -q "$1" "$f"; then
            consoleError "assertFileContains: $f does not contain string: $1"
            dumpFile "$f"
            return 1
        fi
        shift
    done
}


#
# Usage: assertFileDoesNotContain fileName string0 [ ... ]
#
# Argument: - `fileName` - File to search
# Argument: - `string0 ...` - One or more strings which must NOT be found anywhere in `fileName`
# Exit code: - `1` - If the assertions fails
# Exit code: - `0` - If the assertion succeeds
# Local cache: None
# Environment: If the file does not exist, this will fail.
# Example: assertFileDoesNotContain $logFile error Error ERROR
# Example: assertFileDoesNotContain $logFile warning Warning WARNING
#
assertFileDoesNotContain() {
    local f=$1

    shift
    if [ ! -f "$f" ]; then
        consoleError "assertFileDoesNotContain: $f is not a file: $*"
    fi
    while [ $# -gt 0 ]; do
        if grep -q "$1" "$f"; then
            consoleError "assertFileDoesNotContain: $f does contain string: $1"
            dumpFile "$f"
            return 1
        fi
        shift
    done
}
