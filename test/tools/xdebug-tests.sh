#!/usr/bin/env bash
#
# xdebug tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: package-install
testXdebugInstall() {
  assertExitCode 0 xdebugInstall || return $?
  assertExitCode 0 xdebugEnable || return $?
  assertExitCode 0 xdebugDisable || return $?
}
