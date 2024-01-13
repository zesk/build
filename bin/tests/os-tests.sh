#!/usr/bin/env bash
#
# tests-tests.sh
#
# Tests tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
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

  if ! assertGreaterThan "$bTime" "$aTime" "bTime > aTime" ||
    ! assertGreaterThan "$cTime" "$aTime" "cTime > aTime" ||
    ! assertExitCode 0 isNewestFile "c" "a" ||
    ! assertExitCode 0 isNewestFile "c" "b" ||
    ! assertExitCode 0 isNewestFile "b" "a" ||
    ! assertExitCode 1 isNewestFile "b" "c" ||
    ! assertExitCode 1 isNewestFile "a" "c" ||
    ! assertExitCode 1 isNewestFile "a" "b"; then
    return 1
  fi
}

tests+=(testMemoryRelated)
testMemoryRelated() {
  local rss vsz

  rss=$(processMemoryUsage $$)
  vsz=$(processVirtualMemoryUsage $$)

  assertExitCode 0 isInteger "$rss"
  assertExitCode 0 isInteger "$vsz"

  assertGreaterThan 5 "$rss" "pid $$ rss $rss"
  assertGreaterThan 5 "$vsz" "pid $$ virtual memory $vsz"
  assertGreaterThan "$vsz" "$rss" "pid $$  rss $rss, virtual memory $vsz"
}

tests=(testRunCount)
testRunCount() {
  assertEquals "$(runCount 10 echo -n .)" ".........."
  assertEquals "$(runCount 20 echo -n .)" "...................."
  assertExitCode 2 runCount -4923 echo busted
  assertExitCode 2 runCount 33.3 echo busted
  assertExitCode 2 runCount 4.0 echo busted
  assertExitCode 2 runCount thirty echo busted
}
tests=(testEnvironmentVariables)
testEnvironmentVariables() {
  local e
  e=$(mktemp)
  export BUILD_TEST_UNIQUE=1
  environmentVariables > "$e"
  assertFileContains BUILD_TEST_UNIQUE "$e"
  assertFileContains HOME "$e"
  assertFileContains PATH "$e"
  rm "$e"
}
