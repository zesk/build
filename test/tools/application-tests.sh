#!/usr/bin/env bash
#
# application-tests.sh
#
# API tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testApplicationHome() {
  local handler="returnMessage"

  mockEnvironmentStart BUILD_COLORS
  mockEnvironmentStart XDG_STATE_HOME
  export XDG_STATE_HOME

  XDG_STATE_HOME=$(fileTemporaryName "$handler" -d) || return $?

  decorate info "New XDG_STATE_HOME is $XDG_STATE_HOME"
  assertFileDoesNotExist "$XDG_STATE_HOME/.applicationHome" || return $?
  assertExitCode --stdout-match "Application home set" 0 applicationHome "$HOME" || return $?
  assertFileContains --line "$LINENO" "$XDG_STATE_HOME/.applicationHome" "$HOME" || return $?
  catchEnvironment "$handler" rm -rf "$XDG_STATE_HOME" || return $?

  mockEnvironmentStop XDG_STATE_HOME
  mockEnvironmentStop BUILD_COLORS
}

testApplicationHomeAliases() {
  assertExitCode 0 applicationHomeAliases xxx XXX || return $?
}

testBuildApplicationConfigure() {
  local handler="returnMessage"
  local tempPath && tempPath=$(fileTemporaryName "$handler" -d) || return $?
  catchReturn "$handler" buildApplicationConfigure --path "$tempPath" --non-interactive --code 'testApp' --name 'My Test App' || return $?
  assertExitCode 0 buildApplicationConfigure --path "$tempPath" --non-interactive --code 'testApp' --name 'My Test App' || return $?
  local f && for f in "bin/developer.sh" "bin/tools.sh" "bin/install-bin-build.sh"; do
    assertFileExists "$tempPath/$f" || return $?
  done
  local d && for d in "bin/tools" "bin/hooks"; do
    assertDirectoryExists "$tempPath/$d" || return $?
  done
  assertDirectoryDoesNotExist "$tempPath/bin/build" || return $?
  assertExitCode 0 source "$tempPath/bin/tools.sh" || return $?
  assertDirectoryExists "$tempPath/bin/build" || return $?

  catchEnvironment "$handler" rm -rf "$tempPath" || return $?
}
