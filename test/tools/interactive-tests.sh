#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# interactive-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# interactive tests
#

testInteractiveOccasionally() {
  local handler="returnMessage"

  mockEnvironmentStart XDG_CACHE_HOME
  export XDG_CACHE_HOME

  XDG_CACHE_HOME=$(fileTemporaryName "$handler" -d) || return $?

  local name="${FUNCNAME[0]}"
  assertExitCode 0 interactiveOccasionally --delta 10000000000000 "$name" || return $?
  assertExitCode 0 interactiveOccasionally --delta 1 "$name" || return $?
  assertExitCode 0 interactiveOccasionally --delta 1 "$name" || return $?
  assertExitCode 1 interactiveOccasionally --delta 2000 "$name" || return $?
  assertExitCode 1 interactiveOccasionally --delta 2000 "$name" || return $?
  assertExitCode 0 interactiveOccasionally --delta 1 "$name" || return $?

  rm -rf "$XDG_CACHE_HOME" || return $?
  mockEnvironmentStop XDG_CACHE_HOME
}
