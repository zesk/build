#!/usr/bin/env bash
#
# process-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

timingFactor=2

slowDaemon() {
  consoleSuccess Started
  sleep $timingFactor
  consoleSuccess Finished
}

tests+=(testProcessWait)
testProcessWait() {
  local background

  slowDaemon &
  disown
  background=$!

  assertNotExitCode --stderr-match Expired 0 processWait --timeout "$((timingFactor / 2))" "$background" || return $?
  assertExitCode 0 kill -0 "$background" || return $?
  assertExitCode 0 processWait --timeout "$timingFactor" "$background" || return $?
  assertExitCode 0 processWait --timeout "$timingFactor" "$background" || return $?
  assertNotExitCode --stderr-match "must be alive" 0 processWait --require --timeout "$timingFactor" "$background" || return $?
}
