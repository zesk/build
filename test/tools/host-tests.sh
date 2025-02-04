#!/usr/bin/env bash
#
# host-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testHostnameFull() {
  assertExitCode --dump --line "$LINENO" 0 hostnameFull || return $?
  assertExitCode --dump --line "$LINENO" 0 hostnameFull --help || return $?
}
