#!/usr/bin/env bash
#
# console-tests.sh
#
# Console tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testCrontabApplicationUpdate() {
  local handler="_return"
  local emptyPath envFile
  # empty test

  envFile=$(fileTemporaryName "$handler") || return $?
  emptyPath=$(fileTemporaryName "$handler" -d) || return $?
  __environment mkdir -p "$emptyPath/hello" || return $?
  printf "APP=test\n" >>"$emptyPath/hello/.env"
  assertExitCode 0 crontabApplicationUpdate --env-file "$envFile" "$emptyPath" || return $?
  assertExitCode 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" || return $?
  assertExitCode 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" --show || return $?
  printf "* * * * * echo {APP} {APPLICATION_NAME} {APPLICATION_PATH}\n" >>"$emptyPath/hello/root.crontab"
  assertExitCode --stdout-match "test hello" --stdout-match "$emptyPath/hello" 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" --show || return $?

  __catchEnvironment "$handler" rm -rf "$emptyPath" "$envFile" || return $?
}

testCrontabDeprecatedArgument() {
  local handler="_return" envFile

  envFile=$(fileTemporaryName "$handler")
  assertNotExitCode --stderr-ok --line "$LINENO" 0 crontabApplicationUpdate --env "$envFile" || return $?
  rm -rf "$envFile" || return $?
}
