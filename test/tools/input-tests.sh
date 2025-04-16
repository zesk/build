#!/usr/bin/env bash
#
# input-tests.sh
#
# Input tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testInputConfigurationAdd() {
  local savedHome

  export HOME
  savedHome=$HOME

  HOME=$(__environment mktemp -d) || return $?
  assertFileDoesNotExist "$HOME/.input""rc" || return $?
  assertExitCode 0 inputConfigurationAdd "\ep" "history-search-backward" || return $?

  assertFileContains "$HOME/.input""rc" history-search-backward || return $?

  HOME=$savedHome
}
