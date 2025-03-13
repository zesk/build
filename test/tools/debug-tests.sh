#!/usr/bin/env bash
#
# debug-tests.sh
#
# Colors tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
_testBuildDebugEnabledStart() {
  local quietLog="$1"
  decorate info "Suppressing stderr"
  exec 4>&2
  exec 2>"$quietLog"

  #  exec 5>&1
  #  exec 1>"$quietLog"
}

_testBuildDebugEnabledExit() {
  local code="$1" log="${2-}" line="$3"
  #  exec 1>&5
  if [ -n "$log" ]; then
    if [ "$code" != "0" ]; then
      dumpPipe testBuildDebugEnabled <"$log"
    fi
    rm -rf "$log" || :
  fi
  exec 2>&4
  decorate info "Restored stderr at line $line"
  return "$code"
}

testBuildDebugEnabled() {
  local quietLog

  quietLog=$(mktemp)

  export BUILD_DEBUG

  __mockValue BUILD_DEBUG

  assertExitCode --skip-plumber --line "$LINENO" 1 buildDebugEnabled || return $?
  assertNotExitCode --line "$LINENO" 0 buildDebugEnabled || return $?
  # assertNotExitCode --dump --stderr-ok --debug --skip-plumber --line "$LINENO" --leak BUILD_DEBUG 0 buildDebugEnabled || return $?

  BUILD_DEBUG=

  assertNotExitCode --line "$LINENO" 0 buildDebugEnabled || return $?

  __testSection BUILD_DEBUG is ON
  BUILD_DEBUG=1

  _testBuildDebugEnabledStart "$quietLog"

  assertExitCode --line "$LINENO" 0 buildDebugEnabled || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?
  assertExitCode --stderr-ok 0 buildDebugStart || return $?
  assertExitCode --stderr-ok --line "$LINENO" --stderr-ok 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?
  assertExitCode --stderr-ok --line "$LINENO" 0 buildDebugEnabled || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?
  assertExitCode --stderr-ok 0 buildDebugStop || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?
  assertNotExitCode --line "$LINENO" 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?

  __testSection BUILD_DEBUG is OFF
  BUILD_DEBUG=

  assertNotExitCode --line "$LINENO" 0 buildDebugEnabled || _testBuildDebugEnabledExit $? "$quietLog" || return $?
  assertNotExitCode 0 buildDebugStart || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?

  __buildDebugEnable

  assertExitCode --stderr-ok --line "$LINENO" 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?
  # Does not change it (off)
  assertNotExitCode --stderr-ok 0 buildDebugStop || return $?
  assertExitCode --stderr-ok --line "$LINENO" 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?

  # Does change it (on)
  BUILD_DEBUG=1
  assertExitCode --stderr-ok 0 buildDebugStop || return $?
  assertNotExitCode --line "$LINENO" 0 isBashDebug || _testBuildDebugEnabledExit $? "$quietLog" "$LINENO" || return $?
  # Disable anyway

  __buildDebugDisable

  __mockValue BUILD_DEBUG "" --end

  _testBuildDebugEnabledExit 0 "$quietLog" "$LINENO"
}

testErrorExit() {
  local actual

  set +E
  set +e
  assertExitCode --line "$LINENO" 0 isErrorExit || return $?
  set -E
  set -e
  assertExitCode --line "$LINENO" 0 isErrorExit || return $?
  set -E
  set -e
  actual="$(
    isErrorExit
    printf %d $?
  )"
  assertEquals --line "$LINENO" "0" "$actual" "\$(isErrorExit; printf %d $?)" || return $?

  # `set -e` DOES NOT INHERIT TO SUBSHELLS AFAIK and there is no easy way to do so
  # In general, the consensus is to avoid using set -e and use trap ERR
  # 2024-10
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
  assertEquals --line "$LINENO" 108 "$leakCode" || return $?
  assertEquals --line "$LINENO" 108 "$leakCode" || return $?
  assertEquals --line "$LINENO" 108 "$leakCode" || return $?
  assertEquals --line "$LINENO" 108 "$leakCode" || return $?
  assertExitCode --line "$LINENO" 0 plumber || return $?
  assertExitCode --line "$LINENO" 0 plumber plumber echo true || return $?
  assertExitCode --line "$LINENO" 0 plumber plumber decorate warning Hello || return $?
  # Run as a subshell so no leaks
  assertExitCode --line "$LINENO" 0 plumber statusMessage __leakyPipe Cool || return $?
  # Run directly within plumber so catches leaks
  assertExitCode --skip-plumber --line "$LINENO" "0" plumber --leak IS_THIS_GLOBAL --leak wonderful __leakyPipe Cool || return $?

  unset IS_THIS_GLOBAL wonderful
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
  leakCode=$(_code leak)

  buildEnvironmentLoad BUILD_HOME || return $?

  testDir=$(__environment mktemp -d) || return $?

  statusMessage decorate info Copying "${BUILD_HOME-"(blank)"}" to test location
  __environment cp -r "$BUILD_HOME" "$testDir" || return $?
  __environment cd "$testDir" || return $?

  assertEquals --line "$LINENO" 108 "$leakCode" || return $?

  statusMessage decorate info Housekeeper tests
  assertNotExitCode --stderr-match "is not directory" --line "$LINENO" 0 housekeeper --path NOT-A-DIR || return $?
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

testDumpPipe() {
  local ff usage="_return"

  ff=$(fileTemporaryName "$usage") || return $?
  decorate code "Hello, world" >>"$ff"
  assertFileExists --line "$LINENO" "$ff" || return $?
  assertExitCode --line "$LINENO" 0 dumpPipe --vanish "$ff" || return $?
  assertFileDoesNotExist --line "$LINENO" "$ff" || return $?
}

testOutputTrigger() {
  local usage="_return"

  assertExitCode --stderr-match YoYoBaby --line "$LINENO" 1 outputTrigger --name YoYoBaby <<<"Hello" || return $?
  local temp
  temp=$(fileTemporaryName "$usage") || return $?
  assertExitCode --line "$LINENO" 0 outputTrigger --name YoYoBaby <"$temp" || return $?
  __usageEnvironment "$usage" rm -rf "$temp" || return $?
}
