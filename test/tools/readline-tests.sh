#!/usr/bin/env bash
#
# readline-tests.sh
#
# readline tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testReadlineConfigurationAdd() {
  local handler="returnMessage"
  local tempHome

  mockEnvironmentStart HOME

  export HOME

  tempHome=$(fileTemporaryName "$handler" -d) || return $?

  HOME=$tempHome
  assertFileDoesNotExist "$HOME/.input""rc" || return $?
  assertExitCode 0 readlineConfigurationAdd "\ep" "history-search-backward" || return $?

  assertFileContains "$HOME/.input""rc" history-search-backward || return $?

  catchReturn "$handler" rm -rf "$tempHome" || return $?

  mockEnvironmentStop HOME
}
