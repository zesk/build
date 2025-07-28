#!/usr/bin/env bash
#
# console-tests.sh
#
# Console tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testCrontabApplicationUpdate() {
  local usage="_return"
  local emptyPath envFile
  # empty test

  envFile=$(fileTemporaryName "$usage") || return $?
  emptyPath=$(fileTemporaryName "$usage" -d) || return $?
  __environment mkdir -p "$emptyPath/hello" || return $?
  printf "APP=test\n" >>"$emptyPath/hello/.env"
  assertExitCode 0 crontabApplicationUpdate --env-file "$envFile" "$emptyPath" || return $?
  assertExitCode 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" || return $?
  assertExitCode 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" --show || return $?
  printf "* * * * * echo {APP} {APPLICATION_NAME} {APPLICATION_PATH}\n" >>"$emptyPath/hello/root.crontab"
  assertExitCode --stdout-match "test hello" --stdout-match "$emptyPath/hello" 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" --show || return $?

  __catchEnvironment "$usage" rm -rf "$emptyPath" "$envFile" || return $?
}

testCrontabDeprecatedArgument() {
  local usage="_return" envFile

  envFile=$(fileTemporaryName "$usage")
  assertNotExitCode --stderr-ok --line "$LINENO" 0 crontabApplicationUpdate --env "$envFile" || return $?
  rm -rf "$envFile" || return $?
}
