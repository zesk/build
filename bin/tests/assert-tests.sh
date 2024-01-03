#!/usr/bin/env bash
#
# assert-tests.sh
#
# Assertion testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

# IDENTICAL errorEnvironment 1
errorEnvironment=1

tests+=(testAssertions)

testAssertions() {
    if ! assertExitCode 0 assertEquals "aaa" "aaa" ||
        ! assertExitCode "$errorEnvironment" assertEquals "aaa" "aab" ||
        ! assertExitCode "0" assertContains "foo" "food distribution" ||
        ! assertExitCode "$errorEnvironment" assertContains "foo" "good distribution"; then
        return $?
    fi
}
