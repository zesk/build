#!/usr/bin/env bash
#
# tests-tests.sh
#
# Tests tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

declare -a tests

tests+=(testNewestAndOldest)
testNewestAndOldest() {
    local waitSeconds=1 place aTime bTime cTime

    place=$(mktemp -d)
    cd "$place" || return "$errorEnvironment"

    date >"a"
    consoleWarning "testNewestAndOldest: Sleeping $waitSeconds seconds ..."
    sleep "$waitSeconds"
    date >"b"
    consoleWarning "testNewestAndOldest: Sleeping $waitSeconds seconds ..."
    sleep "$waitSeconds"
    date >"c"

    aTime=$(modificationTime "a")
    bTime=$(modificationTime "b")
    cTime=$(modificationTime "c")

    if ! assertOutputEquals "a" oldestFile "a" "b" "c" ||
        ! assertOutputEquals "a" oldestFile "c" "b" "a" ||
        ! assertOutputEquals "a" oldestFile "c" "a" "b" ||
        ! assertOutputEquals "c" newestFile "a" "b" "c" ||
        ! assertOutputEquals "c" newestFile "c" "b" "a" ||
        ! assertOutputEquals "c" newestFile "c" "a" "b"; then
        return 1
    fi

    set -x
    if ! assertGreaterThan "$bTime" "$aTime" "bTime > aTime" ||
        ! assertGreaterThan "$cTime" "$aTime" "cTime > aTime" ||
        ! assertExitCode 0 isNewestFile "c" "a" ||
        ! assertExitCode 0 isNewestFile "c" "b" ||
        ! assertExitCode 0 isNewestFile "b" "a" ||
        ! assertExitCode 1 isNewestFile "b" "c" ||
        ! assertExitCode 1 isNewestFile "a" "c" ||
        ! assertExitCode 1 isNewestFile "a" "b"; then
        set +x
        return 1
    fi
    set +x
}
