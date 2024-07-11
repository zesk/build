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

tests+=(testBuildDebugEnabled)
testBuildDebugEnabled() {
  local saveDebug quietLog

  quietLog=$(mktemp)

  export BUILD_DEBUG

  saveDebug="${BUILD_DEBUG-}"

  unset BUILD_DEBUG || :
  assertNotExitCode 0 buildDebugEnabled || return $?

  BUILD_DEBUG=

  assertNotExitCode 0 buildDebugEnabled || return $?

  testSection BUILD_DEBUG is ON
  BUILD_DEBUG=1

  _testBuildDebugEnabledStart "$quietLog"

  assertExitCode --line "$LINENO" 0 buildDebugEnabled || _testBuildDebugEnabledExit $? "$quietLog" || return $?
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

tests+=(testErrorExit)
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

tests+=(testPlumber)
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
