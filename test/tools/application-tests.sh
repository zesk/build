#!/usr/bin/env bash
#
# application-tests.sh
#
# API tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testApplicationHome() {
  __mockValue XDG_STATE_HOME
  export XDG_STATE_HOME

  XDG_STATE_HOME=$(__environment mktemp -d) || return $?

  decorate info "New XDG_STATE_HOME is $XDG_STATE_HOME"
  assertFileDoesNotExist --line "$LINENO" "$XDG_STATE_HOME/.applicationHome" || return $?
  assertExitCode --stdout-match "Application home set" --line "$LINENO" 0 applicationHome "$HOME" || return $?
  assertFileContains --line "$LINENO" "$XDG_STATE_HOME/.applicationHome" "$HOME" || return $?
  __environment rm -rf "$XDG_STATE_HOME" || return $?

  __mockValue XDG_STATE_HOME "" --end
}
