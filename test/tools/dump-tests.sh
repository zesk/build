#!/usr/bin/env bash
#
# dump-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testDumpPipe() {
  local ff usage="returnMessage"

  ff=$(fileTemporaryName "$usage") || return $?
  decorate code "Hello, world" >>"$ff"
  assertFileExists "$ff" || return $?
  assertExitCode 0 dumpPipe --vanish "$ff" || return $?
  assertFileDoesNotExist "$ff" || return $?
}

# Tag: slow
testDumpEnvironmentSafe() {
  mockEnvironmentStart PRIVATE_THING

  export PRIVATE_THING

  PRIVATE_THING="CriticalThinkingIsInShortSupply"

  local matches=()

  matches=(
    --stdout-no-match "PRIVATE_THING"
    --stdout-no-match "$PRIVATE_THING"
  )
  assertExitCode "${matches[@]}" 0 dumpEnvironment --skip-env PRIVATE_THING || return $?
  matches=(
    --stdout-match "PRIVATE_THING"
    --stdout-no-match "$PRIVATE_THING"
    --stdout-match HIDDEN
  )
  assertExitCode "${matches[@]}" 0 dumpEnvironment --secure-match PRIVATE || return $?
  matches=(
    --stdout-match "PRIVATE_THING"
    --stdout-no-match "$PRIVATE_THING"
    --stdout-match "Z'D STUN"
  )
  assertExitCode "${matches[@]}" 0 dumpEnvironment --secure-match PRIVATE --secure-suffix " Z'D STUN" || return $?
  matches=(
    --stdout-match "PRIVATE_THING"
    --stdout-match "$PRIVATE_THING"
  )
  assertExitCode "${matches[@]}" 0 dumpEnvironment || return $?

  mockEnvironmentStop PRIVATE_THING
}

# Tag: slow
# Tag: slow-non-critical
testDumpEnvironmentUnsafe() {
  mockEnvironmentStart PRIVATE_THING

  export PRIVATE_THING

  PRIVATE_THING="TheDeathOfTheCommons"

  # Argument errors
  assertExitCode --stderr-match "Unknown" 2 dumpEnvironmentUnsafe --secure-match "PRIVATE" || return $?
  assertExitCode --stderr-match "Unknown" 2 dumpEnvironmentUnsafe --secure-suffix "PRIVATE" || return $?
  # Works fine
  assertExitCode --stdout-match "PRIVATE_THING" --stdout-match "$PRIVATE_THING" 0 dumpEnvironmentUnsafe || return $?
  # Partial match does not filter
  assertExitCode --stdout-match "PRIVATE_THING" --stdout-match "$PRIVATE_THING" 0 dumpEnvironmentUnsafe --skip-env PRIVATE || return $?
  # Case match does NOT filter
  assertExitCode --stdout-match "PRIVATE_THING" --stdout-match "$PRIVATE_THING" 0 dumpEnvironmentUnsafe --skip-env private_thing || return $?
  # Exact match does filter
  assertExitCode --stdout-no-match "[SKIPPED VARIABLES]" --stdout-no-match "PRIVATE_THING" --stdout-no-match "$PRIVATE_THING" 0 dumpEnvironmentUnsafe --skip-env PRIVATE_THING || return $?
  # --show-skipped shows name not value
  assertExitCode --stdout-match "[SKIPPED VARIABLES]" --stdout-match "PRIVATE_THING" --stdout-no-match "$PRIVATE_THING" 0 dumpEnvironmentUnsafe --skip-env PRIVATE_THING --show-skipped || return $?

  mockEnvironmentStop PRIVATE_THING
}
