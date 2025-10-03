#!/usr/bin/env bash
#
# xdebug tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: package-install
testXdebugInstall() {
  local handler="returnMessage"

  assertExitCode 0 xdebugInstall || return $?
  assertExitCode 0 xdebugEnable || return $?
  assertExitCode 0 xdebugDisable || return $?

  export TMPDIR

  [ ! -d "$TMPDIR" ] || [ ! -d "$TMPDIR/pear" ] || __catchEnvironment "$handler" rm -rf "$TMPDIR/pear" || return $?
}
