#!/usr/bin/env bash
#
# debug-tests.sh
#
# Colors tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testHousekeeper)
tests+=(testPlumber)
tests+=(testErrorExit)
tests+=(testBuildDebugEnabled)

_testBuildDebugEnabledStart() {
  consoleInfo "Suppressing stderr"
  exec 4>&2
  exec 2>"$quietLog"
}
_testBuildDebugEnabledExit() {
  local code="$1" log="${2-}"
  exec 2>&4
  if [ -n "$log" ]; then
    if [ "$code" != "0" ]; then
      dumpPipe testBuildDebugEnabled <"$log"
    fi
    rm -rf "$log" || :
  fi
  consoleInfo "Restored stderr"
  return "$code"
}

testBuildDebugEnabled() {
  local saveDebug quietLog

  quietLog=$(mktemp)

  export BUILD_DEBUG

  saveDebug="${BUILD_DEBUG-}"

  unset BUILD_DEBUG || :
  assertNotExitCode --leak BUILD_DEBUG 0 buildDebugEnabled || return $?

  BUILD_DEBUG=

  assertNotExitCode 0 buildDebugEnabled || return $?

  testSection BUILD_DEBUG is ON
  BUILD_DEBUG=1

  _testBuildDebugEnabledStart "$quietLog"

  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 buildDebugEnabled || _testBuildDebugEnabledExit $? "$quietLog" || return $?
  buildDebugStart
  assertExitCode --stderr-ok 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" || return $?
  buildDebugStop || _testBuildDebugEnabledExit $? "$quietLog" || return $?
  assertNotExitCode --line "$LINENO" 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" || return $?

  testSection BUILD_DEBUG is OFF
  BUILD_DEBUG=

  assertNotExitCode --line "$LINENO" 0 buildDebugEnabled || _testBuildDebugEnabledExit $? "$quietLog" || return $?
  buildDebugStart || _testBuildDebugEnabledExit $? "$quietLog" || return $?
  set -e
  assertNotExitCode --line "$LINENO" 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" || return $?
  buildDebugStop || return $?
  assertNotExitCode --line "$LINENO" 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" || return $?

  BUILD_DEBUG=$saveDebug

  unset BUILD_DEBUG
  _testBuildDebugEnabledExit 0 "$quietLog"
}

testErrorExit() {
  local actual

  set +e
  assertNotExitCode --line "$LINENO" 0 isErrorExit || return $?
  set -e
  assertNotExitCode --line "$LINENO" 0 isErrorExit || return $?
  actual="$(
    isErrorExit
    printf %d $?
  )"
  assertEquals --line "$LINENO" "1" "$actual" "\$(isErrorExit; printf %d $?)" || return $?

  # `set -e` DOES NOT INHERIT TO SUBSHELLS AFAIK and there is no easy way to do so
  # In general, the consensus is to avoid using set -e and use trap ERR
}

# leaks world
__leakyPipe() {
  export IS_THIS_GLOBAL
  echo "$@"
  wonderful=yes
  IS_THIS_GLOBAL=1
  : "$wonderful"
}

testPlumber() {
  local leakCode

  leakCode=$(_code leak)
  assertEquals 108 "$leakCode" || return $?
  assertExitCode --line "$LINENO" 0 plumber || return $?
  assertExitCode --line "$LINENO" 0 plumber plumber echo true || return $?
  assertExitCode --line "$LINENO" 0 plumber plumber consoleWarning Hello || return $?
  # Run as a subshell so no leaks
  assertExitCode --line "$LINENO" 0 plumber statusMessage __leakyPipe Cool || return $?
  # Run directly within plumber so catches leaks
  assertExitCode --line "$LINENO" --stderr-match IS_THIS_GLOBAL --stderr-match wonderful "$leakCode" plumber __leakyPipe Cool || return $?
}

__writeTo() {
  while [ $# -gt 0 ]; do
    printf "%s\n" "$(randomString)" >"$1"
    shift
  done
}

testHousekeeper() {
  local leakCode matches testFiles
  local testDir testFile

  export BUILD_HOME
  leakCode=$(_code LeAk)

  buildEnvironmentLoad BUILD_HOME || return $?

  testDir=$(__environment mktemp -d) || return $?

  statusMessage consoleInfo Copying "${BUILD_HOME-"(blank)"}" to test location
  __environment cp -r "$BUILD_HOME" "$testDir" || return $?
  __environment cd "$testDir" || return $?

  assertEquals 108 "$leakCode" || return $?

  statusMessage consoleInfo Housekeeper tests
  assertNotExitCode --stderr-match "is not directory" --line "$LINENO" 0 housekeeper NOT-A-DIR || return $?
  assertNotExitCode --stderr-match "not callable" --line "$LINENO" 0 housekeeper "$testDir" "NotABinary" || return $?

  # Simple case - nothing
  assertExitCode --line "$LINENO" 0 housekeeper "$testDir" __writeTo || return $?

  # Write 5 files
  testFiles=(dust dirt cobwebs cruft temporary-files)
  matches=()
  for testFile in "${testFiles[@]}"; do
    matches+=(--stderr-match "$testFile")
  done
  assertNotExitCode --line "$LINENO" "${matches[@]}" 0 housekeeper "$testDir" __writeTo "${testFiles[@]}" || return $?

  # Change dust
  matches=(
    --stderr-match "dust"
    --stderr-no-match "dirt"
    --stderr-no-match "cobwebs"
    --stderr-no-match "cruft"
    --stderr-no-match "temporary-files"
  )
  assertNotExitCode --line "$LINENO" "${matches[@]}" 0 housekeeper "$testDir" __writeTo dust || return $?

  matches=(
    --stderr-no-match "dust"
    --stderr-no-match "dirt"
    --stderr-match "cobwebs"
    --stderr-no-match "cruft"
    --stderr-no-match "temporary-files"
  )
  # Remove cobwebs
  assertNotExitCode --line "$LINENO" "${matches[@]}" 0 housekeeper "$testDir" rm cobwebs || return $?
  # Remove multiple
  matches=(
    --stderr-match "dust"
    --stderr-match "dirt"
    --stderr-no-match "cobwebs"
    --stderr-match "cruft"
    --stderr-match "temporary-files"
  )
  testFiles=(dust dirt cruft temporary-files)
  assertNotExitCode --line "$LINENO" "${matches[@]}" 0 housekeeper "$testDir" rm -f "${testFiles[@]}" || return $?

  __environment rm -rf "$testDir" || return $?
}
