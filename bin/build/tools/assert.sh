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
assertNotExitCode() {
    local expected=$1 actual bin=$2

    shift
    shift
    actual=$(
        "$bin" "$@"
        echo "$?"
    )
    assertNotEquals "$expected" "$actual" "$* exit code should not equal expected $expected ($actual)"
}
#
# assertOutputContains TERM environmentVariables
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

randomString() {
    head --bytes=64 /dev/random | md5sum | cut -f 1 -d ' '
}
