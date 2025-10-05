#!/usr/bin/env bash
#
# os-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testNewestAndOldest() {
  local handler="returnMessage"
  local waitSeconds=1 place aTime bTime cTime

  place=$(fileTemporaryName "$handler" -d) || return $?
  catchEnvironment "$handler" muzzle pushd "$place" || return $?

  date >"a"
  decorate info "testNewestAndOldest: Sleeping $waitSeconds seconds ..."
  sleep "$waitSeconds"
  date >"b"
  decorate info "testNewestAndOldest: Sleeping $waitSeconds seconds ..."
  sleep "$waitSeconds"
  date >"c"

  aTime=$(catchReturn "$handler" fileModificationTime "a") || return $?
  bTime=$(catchReturn "$handler" fileModificationTime "b") || return $?
  cTime=$(catchReturn "$handler" fileModificationTime "c") || return $?

  assertOutputEquals "a" fileOldest "a" "b" "c" || return $?
  assertOutputEquals "a" fileOldest "c" "b" "a" || return $?
  assertOutputEquals "a" fileOldest "c" "a" "b" || return $?
  assertOutputEquals --line "$LINENO" "c" fileNewest "a" "b" "c" || return $?
  assertOutputEquals --line "$LINENO" "c" fileNewest "c" "b" "a" || return $?
  assertOutputEquals --line "$LINENO" "c" fileNewest "c" "a" "b" || return $?

  assertGreaterThan --line "$LINENO" "$bTime" "$aTime" "bTime > aTime" || return $?
  assertGreaterThan --line "$LINENO" "$cTime" "$aTime" "cTime > aTime" || return $?
  assertExitCode 0 fileIsNewest "c" "a" || return $?
  assertExitCode 0 fileIsNewest "c" "b" || return $?
  assertExitCode 0 fileIsNewest "b" "a" || return $?
  assertExitCode 1 fileIsNewest "b" "c" || return $?
  assertExitCode 1 fileIsNewest "a" "c" || return $?
  assertExitCode 1 fileIsNewest "a" "b" || return $?

  catchEnvironment "$handler" muzzle popd || return $?
  catchReturn "$handler" rm -rf "$place" || return $?
}

testMemoryRelated() {
  local rss vsz

  if ! rss=$(processMemoryUsage $$); then
    decorate error processMemoryUsage $$ failed
    return 1
  fi
  if ! vsz=$(processVirtualMemoryAllocation $$); then
    decorate error processVirtualMemoryAllocation $$ failed
    return 1
  fi

  assertExitCode 0 isInteger "$rss" || return $?
  assertExitCode 0 isInteger "$vsz" || return $?

  assertGreaterThan --line "$LINENO" "$rss" 1024 "pid $$ rss $rss" || return $?
  assertGreaterThan --line "$LINENO" "$vsz" 1024 "pid $$ virtual memory $vsz" || return $?
  assertGreaterThan --line "$LINENO" "$vsz" "$rss" "pid $$  rss $rss, virtual memory $vsz" || return $?
}

testRunCount() {
  assertEquals "$(runCount 10 echo -n .)" ".........." || return $?
  assertEquals "$(runCount 20 echo -n .)" "...................." || return $?
  assertExitCode --stderr-match 'positive integer' 2 runCount -4923 echo busted || return $?
  assertExitCode --stderr-match 'positive integer' 2 runCount 33.3 echo busted || return $?
  assertExitCode --stderr-match 'positive integer' 2 runCount 4.0 echo busted || return $?
  assertExitCode --stderr-match 'positive integer' 2 runCount thirty echo busted || return $?
}

testServiceToPortStandard() {
  assertEquals "$(serviceToStandardPort ssh)" 22 ssh || return $?
  assertEquals "$(serviceToStandardPort "ssh ")" 22 ssh || return $?
  assertEquals "$(serviceToStandardPort " ssh ")" 22 ssh || return $?
  assertEquals "$(serviceToStandardPort http)" 80 http || return $?
  assertEquals "$(serviceToStandardPort "         http     ")" 80 http || return $?
  assertEquals "$(serviceToStandardPort https)" 443 https || return $?
  assertEquals "$(serviceToStandardPort mariadb)" 3306 mariadb || return $?
  assertEquals "$(serviceToStandardPort mysql)" 3306 mysql || return $?
  assertEquals "$(serviceToStandardPort postgres)" 5432 postgres || return $?
  assertNotExitCode --stderr-match 'arguments' 0 serviceToStandardPort || return $?
  assertNotExitCode --stderr-match unknown 0 serviceToStandardPort rtmp || return $?
  assertNotExitCode --stderr-match unknown 0 serviceToStandardPort echo || return $?
  assertNotExitCode --stderr-match blank 0 serviceToStandardPort "" || return $?
  assertNotExitCode --stderr-match unknown 0 serviceToStandardPort "22" || return $?
  assertNotExitCode --stderr-match unknown 0 serviceToStandardPort ".https" || return $?
  assertNotExitCode --stderr-match blank 0 serviceToStandardPort " " || return $?
}

testServiceToPort() {
  assertEquals "$(serviceToPort ssh)" 22 ssh || return $?
  assertEquals "$(serviceToPort "ssh ")" 22 ssh || return $?
  assertEquals "$(serviceToPort " ssh ")" 22 ssh || return $?
  assertEquals "$(serviceToPort http)" 80 http || return $?
  assertEquals "$(serviceToPort "         http     ")" 80 http || return $?
  assertEquals "$(serviceToPort https)" 443 https || return $?
  assertEquals "$(serviceToPort mariadb)" 3306 mariadb || return $?
  assertEquals "$(serviceToPort mysql)" 3306 mysql || return $?
  assertEquals "$(serviceToPort postgres)" 5432 postgres || return $?
  assertEquals "$(serviceToPort echo)" 7 echo || return $?

  assertNotExitCode --stderr-ok 0 serviceToPort || return $?

  assertNotExitCode --stderr-match blank 0 serviceToPort "" || return $?
  assertNotExitCode --stderr-match unknown 0 serviceToPort "22" || return $?
  assertNotExitCode --stderr-match unknown 0 serviceToPort ".https" || return $?
  assertNotExitCode --stderr-match "whitespace" 0 serviceToPort " " || return $?
}

testExtensionLists() {
  local handler="returnMessage"
  local target me

  me=$(catchEnvironment "$handler" realPath "${BASH_SOURCE[0]}") || return $?

  export BUILD_HOME
  assertExitCode 0 buildEnvironmentLoad BUILD_HOME || return $?

  target=$(fileTemporaryName "$handler" -d) || return $?

  assertDirectoryEmpty --line "$LINENO" "$target" || return $?
  find "$BUILD_HOME/test" -type f ! -path '*/.*/*' | extensionLists --clean "$target"

  assertDirectoryNotEmpty --line "$LINENO" "$target" || return $?
  assertFileContains --line "$LINENO" "$target/@" "$me" || return $?
  assertFileContains --line "$LINENO" "$target/sh" "$me" || return $?
  assertFileContains --line "$LINENO" "$target/php" "test/example/simple-php/bin/cron.php" || return $?
  assertFileContains --line "$LINENO" "$target/env" "test/example/bad.env" || return $?
  assertFileContains --line "$LINENO" "$target/md" "test/example/mapTokensBad.md" || return $?$()
  assertFileContains --line "$LINENO" "$target/txt" "test/example/identical-source.txt" || return $?

  rm -rf "$target" || return $?
}
