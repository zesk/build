#!/usr/bin/env bash
#
# application-tests.sh
#
# API tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testApplicationHome() {
  local savedHome

  export HOME
  savedHome=$HOME
  HOME=$(__environment mktemp -d) || return $?

  decorate info "New Home is $HOME"
  assertFileDoesNotExist --line "$LINENO" "$HOME/.applicationHome" || return $?
  assertExitCode --stdout-match "Application home set" --line "$LINENO" 0 applicationHome "$HOME" || return $?
  assertFileContains --line "$LINENO" "$HOME/.applicationHome" "$HOME" || return $?
  __environment rm -rf "$HOME" || return $?

  HOME=$savedHome
}
