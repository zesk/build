#!/usr/bin/env bash
#
# console-tests.sh
#
# Console tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
declare -a tests
tests+=(crontabApplicationUpdateTest)

crontabApplicationUpdateTest() {
  local emptyPath envFile
  # empty test

  envFile=$(mktemp) || _environment mktemp || return $?
  emptyPath=$(mktemp -d) || _environment mktemp -d || return $?
  __environment mkdir -p "$emptyPath/hello" || return $?
  printf "APP=test\n" >>"$emptyPath/hello/.env"
  assertExitCode 0 crontabApplicationUpdate --env-file "$envFile" "$emptyPath" || return $?
  assertExitCode 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" || return $?
  assertExitCode 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" --show || return $?
  printf "* * * * * echo {APP} {APPLICATION_NAME} {APPLICATION_PATH}\n" >>"$emptyPath/hello/root.crontab"
  assertExitCode --stdout-match "test hello" --stdout-match "$emptyPath/hello" 0 crontabApplicationUpdate --user root --env-file "$envFile" "$emptyPath" --show || return $?

  rm -rf "$emptyPath" || :
}
