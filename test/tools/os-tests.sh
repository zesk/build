#!/usr/bin/env bash
#
# os-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testNewestAndOldest() {
  local waitSeconds=1 place aTime bTime cTime

  place=$(mktemp -d) || _environment mktemp || return $?
  __environment cd "$place" || return $?

  date >"a"
  consoleInfo "testNewestAndOldest: Sleeping $waitSeconds seconds ..."
  sleep "$waitSeconds"
  date >"b"
  consoleInfo "testNewestAndOldest: Sleeping $waitSeconds seconds ..."
  sleep "$waitSeconds"
  date >"c"

  aTime=$(modificationTime "a") || _environment modificationTime a failed || return $?
  bTime=$(modificationTime "b") || _environment modificationTime b failed || return $?
  cTime=$(modificationTime "c") || _environment modificationTime c failed || return $?

  if ! assertOutputEquals --line "$LINENO" "a" oldestFile "a" "b" "c" ||
    ! assertOutputEquals --line "$LINENO" "a" oldestFile "c" "b" "a" ||
    ! assertOutputEquals --line "$LINENO" "a" oldestFile "c" "a" "b" ||
    ! assertOutputEquals --line "$LINENO" "c" newestFile "a" "b" "c" ||
    ! assertOutputEquals --line "$LINENO" "c" newestFile "c" "b" "a" ||
    ! assertOutputEquals --line "$LINENO" "c" newestFile "c" "a" "b"; then
    return 1
  fi

  if ! assertGreaterThan --line "$LINENO" "$bTime" "$aTime" "bTime > aTime" ||
    ! assertGreaterThan --line "$LINENO" "$cTime" "$aTime" "cTime > aTime" ||
    ! assertExitCode --line "$LINENO" 0 isNewestFile "c" "a" ||
    ! assertExitCode --line "$LINENO" 0 isNewestFile "c" "b" ||
    ! assertExitCode --line "$LINENO" 0 isNewestFile "b" "a" ||
    ! assertExitCode --line "$LINENO" 1 isNewestFile "b" "c" ||
    ! assertExitCode --line "$LINENO" 1 isNewestFile "a" "c" ||
    ! assertExitCode --line "$LINENO" 1 isNewestFile "a" "b"; then
    return 1
  fi
}

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

  assertExitCode --line "$LINENO" 0 isInteger "$rss" || return $?
  assertExitCode --line "$LINENO" 0 isInteger "$vsz" || return $?

  assertGreaterThan --line "$LINENO" "$rss" 1024 "pid $$ rss $rss" || return $?
  assertGreaterThan --line "$LINENO" "$vsz" 1024 "pid $$ virtual memory $vsz" || return $?
  assertGreaterThan --line "$LINENO" "$vsz" "$rss" "pid $$  rss $rss, virtual memory $vsz" || return $?
}

testRunCount() {
  assertEquals --line "$LINENO" "$(runCount 10 echo -n .)" ".........." || return $?
  assertEquals --line "$LINENO" "$(runCount 20 echo -n .)" "...................." || return $?
  assertExitCode --line "$LINENO" --stderr-match 'positive integer' 2 runCount -4923 echo busted || return $?
  assertExitCode --line "$LINENO" --stderr-match 'positive integer' 2 runCount 33.3 echo busted || return $?
  assertExitCode --line "$LINENO" --stderr-match 'positive integer' 2 runCount 4.0 echo busted || return $?
  assertExitCode --line "$LINENO" --stderr-match 'positive integer' 2 runCount thirty echo busted || return $?
}

testServiceToPortStandard() {
  assertEquals --line "$LINENO" "$(serviceToStandardPort ssh)" 22 ssh || return $?
  assertEquals --line "$LINENO" "$(serviceToStandardPort "ssh ")" 22 ssh || return $?
  assertEquals --line "$LINENO" "$(serviceToStandardPort " ssh ")" 22 ssh || return $?
  assertEquals --line "$LINENO" "$(serviceToStandardPort http)" 80 http || return $?
  assertEquals --line "$LINENO" "$(serviceToStandardPort "         http     ")" 80 http || return $?
  assertEquals --line "$LINENO" "$(serviceToStandardPort https)" 443 https || return $?
  assertEquals --line "$LINENO" "$(serviceToStandardPort mariadb)" 3306 mariadb || return $?
  assertEquals --line "$LINENO" "$(serviceToStandardPort mysql)" 3306 mysql || return $?
  assertEquals --line "$LINENO" "$(serviceToStandardPort postgres)" 5432 postgres || return $?
  assertNotExitCode --line "$LINENO" --stderr-match 'arguments' 0 serviceToStandardPort || return $?
  assertNotExitCode --line "$LINENO" --stderr-match unknown 0 serviceToStandardPort rtmp || return $?
  assertNotExitCode --line "$LINENO" --stderr-match unknown 0 serviceToStandardPort echo || return $?
  assertNotExitCode --line "$LINENO" --stderr-match unknown 0 serviceToStandardPort "" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match unknown 0 serviceToStandardPort "22" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match unknown 0 serviceToStandardPort ".https" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match unknown 0 serviceToStandardPort " " || return $?
}

testServiceToPort() {
  assertEquals --line "$LINENO" "$(serviceToPort ssh)" 22 ssh || return $?
  assertEquals --line "$LINENO" "$(serviceToPort "ssh ")" 22 ssh || return $?
  assertEquals --line "$LINENO" "$(serviceToPort " ssh ")" 22 ssh || return $?
  assertEquals --line "$LINENO" "$(serviceToPort http)" 80 http || return $?
  assertEquals --line "$LINENO" "$(serviceToPort "         http     ")" 80 http || return $?
  assertEquals --line "$LINENO" "$(serviceToPort https)" 443 https || return $?
  assertEquals --line "$LINENO" "$(serviceToPort mariadb)" 3306 mariadb || return $?
  assertEquals --line "$LINENO" "$(serviceToPort mysql)" 3306 mysql || return $?
  assertEquals --line "$LINENO" "$(serviceToPort postgres)" 5432 postgres || return $?
  assertEquals --line "$LINENO" "$(serviceToPort echo)" 7 echo || return $?

  assertNotExitCode --stderr-ok 0 serviceToPort || return $?

  assertNotExitCode --line "$LINENO" --stderr-match blank 0 serviceToPort "" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match unknown 0 serviceToPort "22" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match unknown 0 serviceToPort ".https" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "whitespace" 0 serviceToPort " " || return $?
}

testExtensionLists() {
  local target me

  me=$(__environment realPath "${BASH_SOURCE[0]}") || return $?

  export BUILD_HOME
  assertExitCode --line "$LINENO" 0 buildEnvironmentLoad BUILD_HOME || return $?

  target=$(mktemp -d) || _environment "mktemp -d" || return $?

  assertDirectoryEmpty --line "$LINENO" "$target" || return $?
  find "$BUILD_HOME/test" -type f ! -path '*/.*/*' | extensionLists --clean "$target"

  assertDirectoryNotEmpty --line "$LINENO" "$target" || return $?
  assertFileContains --line "$LINENO" "$target/@" "$me" || return $?
  assertFileContains --line "$LINENO" "$target/sh" "$me" || return $?
  assertFileContains --line "$LINENO" "$target/php" "test/example/simple-php/bin/cron.php" || return $?
  assertFileContains --line "$LINENO" "$target/env" "test/example/bad.env" || return $?
  assertFileContains --line "$LINENO" "$target/md" "test/example/listTokensBad.md" || return $?$()
  assertFileContains --line "$LINENO" "$target/txt" "test/example/identical-source.txt" || return $?

  rm -rf "$target" || return $?
}
