#!/usr/bin/env bash
#
# pcregrep-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

test_pcregrepBinary() {
  local binary

  binary=$(pcregrepBinary)
  assertExitCode --stderr-ok 2 pcregrepBinary --no-arguments-allowed || return $?
  assertExitCode 0 pcregrepBinary --help || return $?
  assertContains pcre "$binary" || return $?
}

# Tag: package-install
test_pcregrepInstall() {
  assertExitCode 0 pcregrepInstall || return $?
  assertExitCode --stderr-ok 2 pcregrepInstall --no-arguments-allowed || return $?
  assertExitCode 0 pcregrepInstall --help || return $?
  assertExitCode 0 whichExists "$(pcregrepBinary)" || return $?
}
