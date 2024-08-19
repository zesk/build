#!/usr/bin/env bash
#
# process-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

_timingFactor() {
  if isBitBucketPipeline; then
    printf "%d\n" 10
  else
    printf "%d\n" 4
  fi
}

slowDaemon() {
  local start timingFactor
  local this

  timingFactor="$(_timingFactor)"
  this="${FUNCNAME[0]}"

  start=$(beginTiming) || _environment "$this beginTiming failed" || return $?
  consoleSuccess "Started $this for $timingFactor seconds"
  sleep "$timingFactor"
  reportTiming "$start" "$this finished in"
}

testProcessWait() {
  local background timingFactor

  slowDaemon &
  disown
  background=$!

  timingFactor="$(_timingFactor)"

  export BUILD_DEBUG_LINES=9999
  assertNotExitCode --dump --stderr-match Expired 0 processWait --timeout "$((timingFactor / 2))" "$background" || return $?
  assertExitCode 0 kill -0 "$background" || return $?
  assertExitCode 0 processWait --timeout "$timingFactor" "$background" || return $?
  assertExitCode 0 processWait --timeout "$timingFactor" "$background" || return $?
  assertNotExitCode --stderr-match "must be alive" 0 processWait --require --timeout "$timingFactor" "$background" || return $?
  unset BUILD_DEBUG_LINES
}
