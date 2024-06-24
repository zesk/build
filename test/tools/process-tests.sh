#!/usr/bin/env bash
#
# process-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

if isBitBucketPipeline; then
  timingFactor=10
else
  timingFactor=4
fi

slowDaemon() {
  local start
  local this

  this="${FUNCNAME[0]}"

  start=$(beginTiming) || _environment "$this beginTiming failed" || return $?
  consoleSuccess "Started $this for $timingFactor seconds"
  sleep "$timingFactor"
  reportTiming "$start" "$this finished in"
}

tests+=(testProcessWait)
testProcessWait() {
  local background

  slowDaemon &
  disown
  background=$!

  export BUILD_DEBUG_LINES=9999
  assertNotExitCode --dump --stderr-match Expired 0 processWait --timeout "$((timingFactor / 2))" "$background" || return $?
  assertExitCode 0 kill -0 "$background" || return $?
  assertExitCode 0 processWait --timeout "$timingFactor" "$background" || return $?
  assertExitCode 0 processWait --timeout "$timingFactor" "$background" || return $?
  assertNotExitCode --stderr-match "must be alive" 0 processWait --require --timeout "$timingFactor" "$background" || return $?
  unset BUILD_DEBUG_LINES
}
