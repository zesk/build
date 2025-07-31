#!/usr/bin/env bash
#
# process-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

_timingFactor() {
  if isBitBucketPipeline; then
    printf "%d\n" 16
  else
    printf "%d\n" 6
  fi
}

__slowDaemon() {
  local start timingFactor
  local this

  timingFactor="$(_timingFactor)"
  this="${FUNCNAME[0]}"

  start=$(timingStart) || _environment "$this timingStart failed" || return $?
  decorate success "Started $this for $timingFactor seconds"
  sleep "$timingFactor"
  timingReport "$start" "$this finished in"
}

testProcessWait() {
  local background timingFactor

  printf "%s %s\n" "$(decorate info "Uptime")" "$(decorate code "$(uptime)")"
  __slowDaemon &
  disown
  background=$!

  timingFactor="$(_timingFactor)"

  __mockValue BUILD_DEBUG_LINES "" 9999
  assertNotExitCode --stderr-match Expired 0 processWait --timeout "$((timingFactor / 2))" "$background" || return $?
  assertExitCode 0 kill -0 "$background" || return $?
  assertExitCode 0 processWait --timeout "$timingFactor" "$background" || return $?
  assertExitCode 0 processWait --timeout "$timingFactor" "$background" || return $?
  assertNotExitCode --stderr-match "must be alive" 0 processWait --require --timeout "$timingFactor" "$background" || return $?
  __mockValueStop BUILD_DEBUG_LINES
}
