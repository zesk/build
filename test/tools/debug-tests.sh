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

tests+=(testBuildDebugEnabled)

testBuildDebugEnabled() {
  local saveDebug saveError

  export BUILD_DEBUG

  saveDebug="${BUILD_DEBUG-}"

  unset BUILD_DEBUG || :
  assertNotExitCode 0 buildDebugEnabled || return $?

  BUILD_DEBUG=

  assertNotExitCode 0 buildDebugEnabled || return $?

  testSection BUILD_DEBUG is ON
  BUILD_DEBUG=1

  assertExitCode 0 buildDebugEnabled || return $?
  buildDebugStart
  assertExitCode --stderr-ok 0 isBashDebug || return $?
  buildDebugStop || return $?
  assertNotExitCode 0 isBashDebug || return $?

  testSection BUILD_DEBUG is OFF
  BUILD_DEBUG=

  assertNotExitCode 0 buildDebugEnabled || return $?
  buildDebugStart || return $?
  set -e
  assertNotExitCode 0 isBashDebug || return $?
  buildDebugStop || return $?
  assertNotExitCode 0 isBashDebug || return $?

  BUILD_DEBUG=$saveDebug

  unset BUILD_DEBUG
}

tests+=(testBuildDebugEnabled)

testSaveErrorExit() {
  local saveError

  saveError=$(saveErrorExit) || return $?

  set -e

  assertExitCode 0 isErrorExit || return $?
  assertEquals "1" "$(saveErrorExit)" "saveErrorExit should be 1 after set -e" || return $?

  set +e
  assertNotExitCode 0 isErrorExit || return $?
  assertEquals "" "$(saveErrorExit)" || return $?
  assertEquals "" "$(saveErrorExit)" "saveErrorExit should be blank after set +e" || return $?

  restoreErrorExit 1
  assertExitCode 0 isErrorExit || return $?
  assertEquals "1" "$(saveErrorExit)" "saveErrorExit should be 1 after set -e" || return $?

  restoreErrorExit 0
  assertNotExitCode 0 isErrorExit || return $?
  assertEquals "" "$(saveErrorExit)" "saveErrorExit should be blank after set +e" || return $?

  restoreErrorExit "$saveError" || return $?
}
