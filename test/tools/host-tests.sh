#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# host-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testHostnameFull() {
  local handler="returnMessage"

  catchReturn "$handler" timing hostnameFull || return $?
  assertExitCode --line "$LINENO" 0 hostnameFull || return $?
  assertExitCode --line "$LINENO" 0 hostnameFull --help || return $?
}
