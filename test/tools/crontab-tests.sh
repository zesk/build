#!/usr/bin/env bash
#
# console-tests.sh
#
# Console tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(crontabApplicationSyncTest)
crontabApplicationSyncTest() {
  local emptyPath envFile
  # empty test

  envFile=$(mktemp) || _environment mktemp || return $?
  emptyPath=$(mktemp -d) || _environment mktemp -d || return $?
  __environment mkdir -p "$emptyPath/hello" || return $?
  printf "APP=test\n" >>"$emptyPath/hello/.env"
  assertExitCode 0 crontabApplicationSync --env "$envFile" "$emptyPath" || return $?
  assertExitCode 0 crontabApplicationSync --user root --env "$envFile" "$emptyPath" || return $?
  assertExitCode 0 crontabApplicationSync --user root --env "$envFile" "$emptyPath" --show || return $?
  printf "* * * * * echo {APP} {APPLICATION_NAME} {APPLICATION_PATH}\n" >>"$emptyPath/hello/root.crontab"
  assertExitCode --stdout-match "test hello" --stdout-match "$emptyPath/hello" --dump 0 crontabApplicationSync --user root --env "$envFile" "$emptyPath" --show || return $?

  rm -rf "$emptyPath" || :
}
