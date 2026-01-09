#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# host-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testHostnameFull() {
  assertExitCode --dump --line "$LINENO" 0 hostnameFull || return $?
  assertExitCode --dump --line "$LINENO" 0 hostnameFull --help || return $?
}
