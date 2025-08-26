#!/usr/bin/env bash
#
# application-tests.sh
#
# API tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testApplicationHome() {
  local handler="_return"

  __mockValue XDG_STATE_HOME
  export XDG_STATE_HOME

  XDG_STATE_HOME=$(fileTemporaryName "$handler" -d) || return $?

  decorate info "New XDG_STATE_HOME is $XDG_STATE_HOME"
  assertFileDoesNotExist "$XDG_STATE_HOME/.applicationHome" || return $?
  assertExitCode --stdout-match "Application home set" 0 applicationHome "$HOME" || return $?
  assertFileContains --line "$LINENO" "$XDG_STATE_HOME/.applicationHome" "$HOME" || return $?
  __environment rm -rf "$XDG_STATE_HOME" || return $?

  __mockValueStop XDG_STATE_HOME
}

testApplicationHomeAliases() {
  assertExitCode 0 applicationHomeAliases xxx XXX || return $?
}
