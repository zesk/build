#!/usr/bin/env bash
#
# readline-tests.sh
#
# readline tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testReadlineConfigurationAdd() {
  local handler="_return"
  local savedHome

  export HOME
  savedHome=$HOME

  HOME=$(fileTemporaryName "$handler" -d) || return $?
  assertFileDoesNotExist "$HOME/.input""rc" || return $?
  assertExitCode 0 readlineConfigurationAdd "\ep" "history-search-backward" || return $?

  assertFileContains "$HOME/.input""rc" history-search-backward || return $?

  HOME=$savedHome
}
