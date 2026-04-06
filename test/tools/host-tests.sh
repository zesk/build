#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# host-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testHostnameFull() {
  local handler="returnMessage"

  catchReturn "$handler" timing networkNameFull || return $?
  assertExitCode --line "$LINENO" 0 networkNameFull || return $?
  assertExitCode --line "$LINENO" 0 networkNameFull --help || return $?
}
