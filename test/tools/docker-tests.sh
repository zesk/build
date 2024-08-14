#!/usr/bin/env bash
#
# docker-tests.sh
#
# docker tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

errorEnvironment=1

testCheckDockerEnvFile() {
  local out

  local testFile=./test/example/bad.env || return $?
  assertExitCode --stderr-ok 1 checkDockerEnvFile $testFile || return $?
  assertExitCode --stderr-match TEST_AWS_SECURITY_GROUP 1 checkDockerEnvFile $testFile || return $?
  assertExitCode --stderr-match DOLLAR 1 checkDockerEnvFile $testFile || return $?
  assertExitCode --stderr-no-match GOOD 1 checkDockerEnvFile $testFile || return $?
  assertExitCode --stderr-no-match HELLO 1 checkDockerEnvFile $testFile || return $?

  assertExitCode 0 dockerEnvToBash $testFile || return $?

  out=$(mktemp) || _environment "mktemp" || return $?

  dockerEnvToBash $testFile >"$out" || return $?
  assertFileContains "$out" '\"quotes\"' TEST_AWS_SECURITY_GROUP "DOLLAR=" "QUOTE=" "GOOD=" 'HELLO="W' || return $?
  rm "$out"
}

testDockerEnvToBash() {
  local out err

  out=$(mktemp) || _environment "mktemp" || return $?
  err="$out.err"

  consoleInfo "PWD is $(pwd)"
  if dockerEnvToBash ./test/example/test.env >"$out" 2>"$err"; then
    _environment "dockerEnvToBash SHOULD fail" || return $?
  fi

  # Different than testDockerEnvToBashPipe
  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  # Different than testDockerEnvToBashPipe
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "test.env" "Invalid name" || return $?

  dockerEnvToBash ./test/example/docker.env >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  rm -f "$out" "$err" || :
}

# Same as above but this is a pipe
testDockerEnvToBashPipe() {
  local out err

  out=$(mktemp) || _environment "mktemp" || return $?
  err="$out.err"

  consoleInfo "PWD is $(pwd)"
  if dockerEnvToBash <./test/example/test.env >"$out" 2>"$err"; then
    consoleError "dockerEnvToBash SHOULD fail"
    return $errorEnvironment
  fi

  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  # Different than testDockerEnvToBash
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "Invalid name" || return $?
  # Different than testDockerEnvToBash
  assertFileDoesNotContain "$err" "test.env" || return $?

  dockerEnvToBash <./test/example/docker.env >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  rm -f "$out" "$err" || :
}

testDockerEnvFromBash() {
  local out err

  assertExitCode --stderr-ok 2 dockerEnvFromBashEnv ./test/example/bad.env || return $?

  assertExitCode --stdout-match "host=" --stdout-match "application=beanstalk" --stdout-match "uname=" 0 dockerEnvFromBashEnv ./test/example/bash.env || return $?

  out=$(mktemp) || _environment "mktemp" || return $?
  err=$(mktemp) || _environment "mktemp" || return $?

  dockerEnvFromBashEnv ./test/example/docker.env >"$out" 2>"$err" || return 1

  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "location=" "uname=" || return $?

  rm -f "$out" "$err" || :
}
