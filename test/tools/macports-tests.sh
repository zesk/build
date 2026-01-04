#!/usr/bin/env bash
#
# MacPorts tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testMacPorts() {
  if whichExists port; then
    assertExitCode 0 packageUpdate || return $?
    assertExitCode 0 packageInstall || return $?
    assertExitCode 0 packageInstall || return $?
  fi
}
