#!/usr/bin/env bash
#
# docker-tests.sh
#
# docker tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#


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

  decorate info "PWD is $(pwd)"
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

  decorate info "PWD is $(pwd)"
  if dockerEnvToBash <./test/example/test.env >"$out" 2>"$err"; then
    _environment "dockerEnvToBash SHOULD fail" || return $?
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

  assertExitCode --line "$LINENO" --stderr-ok 2 dockerEnvFromBashEnv ./test/example/bad.env || return $?

  assertExitCode --line "$LINENO" --stdout-match "host=" --stdout-match "application=beanstalk" --stdout-match "uname=" 0 dockerEnvFromBashEnv ./test/example/bash.env || return $?

  out=$(mktemp) || _environment "mktemp" || return $?
  err=$(mktemp) || _environment "mktemp" || return $?

  dockerEnvFromBashEnv ./test/example/bash.env >"$out" 2>"$err" || return 1
  dumpPipe "ERRORS dockerEnvFromBashEnv ./test/example/docker.env" <"$err"
  assertEquals --line "$LINENO" 0 "$(fileSize "$err")" || return $?
  assertFileContains --line "$LINENO" "$out" "host=" "now=" "uname=" || return $?

  rm -f "$out" "$err" || :
}

testAnyEnvToDockerEnv() {
  local testEnv home

  testEnv=$(__environment mktemp) || return $?
  home=$(__environment buildHome) || return $?

  __environment anyEnvToDockerEnv "$testEnv" >"$testEnv.result" || return $?
  dumpPipe "Result - should be blank" <"$testEnv.result"
  assertExitCode --line "$LINENO" 0 isEmptyFile "$testEnv.result" || return $?

  __environment cp "$home/test/example/bash.env" "$testEnv" || return $?

  # mode 1
  __environment anyEnvToDockerEnv "$testEnv" >"$testEnv.result" || return $?
  # as a pipe
  __environment anyEnvToDockerEnv >"$testEnv.result2" <"$testEnv" || return $?
  assertExitCode --dump --line "$LINENO" 0 diff -w "$testEnv.result2" "$testEnv.result" || return $?

  printf -- "%s=%s\n" "NAME" "\"value\"" >"$testEnv"
  assertExitCode --line "$LINENO" --stdout-match 'NAME=value' 0 anyEnvToDockerEnv "$testEnv" || return $?

  rm -rf "$testEnv" "$testEnv.result" "$testEnv.result2"
}

testAnyEnvToBashEnv() {
  local testEnv

  testEnv=$(__environment mktemp) || return $?
  home=$(__environment buildHome) || return $?

  __environment anyEnvToBashEnv "$testEnv" >"$testEnv.result" || return $?
  assertExitCode --line "$LINENO" 0 isEmptyFile "$testEnv.result" || return $?

  echo "$LINENO:${BASH_SOURCE[0]}"
  __environment cp "$home/test/example/docker.env" "$testEnv" || return $?
  echo "$LINENO:${BASH_SOURCE[0]}"

  __environment anyEnvToBashEnv "$testEnv" >"$testEnv.result" || return $?
  echo "$LINENO:${BASH_SOURCE[0]}"

  anyEnvToBashEnv >"$testEnv.result2" <"$testEnv" || return $?
  echo "$LINENO:${BASH_SOURCE[0]}"
  __echo diff -w "$testEnv.result2" "$testEnv.result" || :
  assertExitCode --line "$LINENO" 0 diff -w "$testEnv.result2" "$testEnv.result" || return $?
  echo "$LINENO:${BASH_SOURCE[0]}"

  printf -- "%s=%s\n" "NAME" "\"value\"" >"$testEnv"
  echo "$LINENO:${BASH_SOURCE[0]}"
  assertExitCode --line "$LINENO" --stdout-match 'NAME=value' 0 anyEnvToDockerEnv "$testEnv" || return $?
  echo "$LINENO:${BASH_SOURCE[0]}"

  rm -rf "$testEnv" "$testEnv.result" "$testEnv.result2" || :
}
