#!/usr/bin/env bash
#
# tests-tests.sh
#
# Tests tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

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

  if ! aTime=$(modificationTime "a"); then
    consoleError modificationTime a failed
    return 1
  fi
  if ! bTime=$(modificationTime "b"); then
    consoleError modificationTime b failed
    return 1
  fi
  if ! cTime=$(modificationTime "c"); then
    consoleError modificationTime c failed
    return 1
  fi

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

  if ! rss=$(processMemoryUsage $$); then
    consoleError processMemoryUsage $$ failed
    return 1
  fi
  if ! vsz=$(processVirtualMemoryAllocation $$); then
    consoleError processVirtualMemoryAllocation $$ failed
    return 1
  fi

  assertExitCode 0 isInteger "$rss" || return $?
  assertExitCode 0 isInteger "$vsz" || return $?

  assertGreaterThan "$rss" 1024 "pid $$ rss $rss" || return $?
  assertGreaterThan "$vsz" 1024 "pid $$ virtual memory $vsz" || return $?
  assertGreaterThan "$vsz" "$rss" "pid $$  rss $rss, virtual memory $vsz" || return $?
}

tests+=(testRunCount)
testRunCount() {
  assertEquals "$(runCount 10 echo -n .)" ".........." || return $?
  assertEquals "$(runCount 20 echo -n .)" "...................." || return $?
  assertExitCode 2 runCount -4923 echo busted || return $?
  assertExitCode 2 runCount 33.3 echo busted || return $?
  assertExitCode 2 runCount 4.0 echo busted || return $?
  assertExitCode 2 runCount thirty echo busted || return $?
}

tests+=(testEnvironmentVariables)
testEnvironmentVariables() {
  local e
  e=$(mktemp)
  export BUILD_TEST_UNIQUE=1
  if ! environmentVariables >"$e"; then
    consoleError environmentVariables failed
    return 1
  fi
  assertFileContains "$e" BUILD_TEST_UNIQUE HOME PATH PWD TERM SHLVL || return $?
  prefixLines "environmentVariables: $(consoleCode)" <"$e"
  rm "$e"
}

_assertBetterType() {
  assertEquals "$1" "$(betterType "$2")" "$1 != betterType $2 $(consoleRed "=> $(betterType "$2")")" || return $?
}

tests+=(testBetterType)
testBetterType() {
  _assertBetterType "builtin" return || return $?
  _assertBetterType "builtin" . || return $?
  _assertBetterType "function" testBetterType || return $?
  _assertBetterType "file" "${BASH_SOURCE[0]}" || return $?
  _assertBetterType "directory" ../. || return $?
  _assertBetterType "unknown" fairElections || return $?

  local d
  d=$(mktemp -d)
  requireDirectory "$d/food"
  ln -s "$d/food" "$d/food-link"

  touch "$d/goof"
  ln -s "$d/no-goof" "$d/no-goof-link"
  ln -s "$d/goof" "$d/goof-link"

  _assertBetterType "directory" "$d/food" || return $?
  _assertBetterType "link-directory" "$d/food-link" || return $?
  _assertBetterType "file" "$d/goof" || return $?
  _assertBetterType "link-unknown" "$d/no-goof-link" || return $?
  _assertBetterType "link-file" "$d/goof-link" || return $?

  rm -rf "$d"
}
