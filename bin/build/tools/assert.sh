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
    set +e
    actual=$(
        "$bin" "$@"
        echo "$?"
    )
    set -e
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

assertDirectoryDoesNotExist() {
    local d=$1

    shift
    if [ -d "$d" ]; then
        consoleError "$d was expected to not be a directory but is: $*"
        return 1
    fi
}

assertDirectoryExists() {
    local d=$1

    shift
    if [ ! -d "$d" ]; then
        consoleError "$d was expected to not a directory but is NOT: $*"
        return 1
    fi
}

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
