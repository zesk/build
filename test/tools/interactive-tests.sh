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
  assertExitCode 0 interactiveOccasionally --delta 10000000000000 "${FUNCNAME[0]}" || return $?
  assertExitCode 0 interactiveOccasionally --delta 1 "${FUNCNAME[0]}" || return $?
  assertExitCode 0 interactiveOccasionally --delta 1 "${FUNCNAME[0]}" || return $?
  assertExitCode 1 interactiveOccasionally --delta 2000 "${FUNCNAME[0]}" || return $?
  assertExitCode 1 interactiveOccasionally --delta 2000 "${FUNCNAME[0]}" || return $?
  assertExitCode 0 interactiveOccasionally --delta 1 "${FUNCNAME[0]}" || return $?
}
