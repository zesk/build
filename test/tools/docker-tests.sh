#!/usr/bin/env bash
#
# docker-tests.sh
#
# docker tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

errorEnvironment=1

declare -a tests
tests+=(testCheckDockerEnvFile)

testCheckDockerEnvFile() {
  local testFile=./test/example/bad.env || return $?
  assertExitCode --stderr-ok 1 checkDockerEnvFile $testFile || return $?
  assertOutputContains --stderr --exit 1 TEST_AWS_SECURITY_GROUP checkDockerEnvFile $testFile || return $?
  assertOutputContains --stderr --exit 1 DOLLAR checkDockerEnvFile $testFile || return $?
  assertOutputDoesNotContain --stderr --exit 1 GOOD checkDockerEnvFile $testFile || return $?
  assertOutputDoesNotContain --stderr --exit 1 HELLO checkDockerEnvFile $testFile || return $?

  assertExitCode 0 dockerEnvToBash $testFile || return $?

  if ! out=$(mktemp); then
    return "$errorEnvironment"
  fi
  dockerEnvToBash $testFile >"$out" || return $?
  assertFileContains "$out" '\\"quotes\\"' TEST_AWS_SECURITY_GROUP "DOLLAR=" "QUOTE=" "GOOD=" 'HELLO="W' || return $?
  rm "$out"
}

tests+=(testDockerEnvToBash)

testDockerEnvToBash() {
  local out err

  if ! out=$(mktemp); then
    return "$errorEnvironment"
  fi
  if ! err=$(mktemp); then
    return "$errorEnvironment"
  fi
  consoleInfo "PWD is $(pwd)"
  dockerEnvToBash ./test/example/test.env >"$out" 2>"$err" && return $?

  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "test.env" "Invalid name" || return $?

  dockerEnvToBash ./test/example/docker.env >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  rm -f "$out" "$err" || :
}

tests+=(testDockerEnvFromBash)

testDockerEnvFromBash() {
  local out err

  assertExitCode --stderr-ok 2 dockerEnvFromBash ./test/example/bad.env || return $?

  if ! out=$(mktemp); then
    return "$errorEnvironment"
  fi
  if ! err=$(mktemp); then
    return "$errorEnvironment"
  fi

  assertExitCode 0 dockerEnvFromBash ./test/example/bash.env >"$out" 2>"$err" || return $?

  assertFileContains "$out" "host=" "application=beanstalk" "uname=" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?

  dockerEnvFromBash ./test/example/docker.env >"$out" 2>"$err" || return 1

  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "location=" "uname=" || return $?

  rm -f "$out" "$err" || :
}
