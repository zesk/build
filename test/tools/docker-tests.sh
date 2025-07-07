#!/usr/bin/env bash
#
# docker-tests.sh
#
# docker tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testCheckDockerEnvFile() {
  local usage="_return"
  local out home

  home=$(__catchEnvironment "$usage" buildHome) || return $?

  local testFile="$home/test/example/bad.env"

  assertExitCode --stderr-ok 1 checkDockerEnvFile "$testFile" || return $?
  assertExitCode --stderr-match TEST_AWS_SECURITY_GROUP 1 checkDockerEnvFile "$testFile" || return $?
  assertExitCode --stderr-match DOLLAR 1 checkDockerEnvFile "$testFile" || return $?
  assertExitCode --stderr-no-match GOOD 1 checkDockerEnvFile "$testFile" || return $?
  assertExitCode --stderr-no-match HELLO 1 checkDockerEnvFile "$testFile" || return $?

  assertExitCode 0 dockerEnvToBash "$testFile" || return $?

  out=$(__catchEnvironment "$usage" fileTemporaryName "$usage") || return $?

  __catchEnvironment "$usage" dockerEnvToBash "$testFile" >"$out" || return $?
  assertFileContains "$out" '\"quotes\"' TEST_AWS_SECURITY_GROUP "DOLLAR=" "QUOTE=" "GOOD=" 'HELLO="W' || return $?
  __catchEnvironment "$usage" rm "$out" || return $?
}

testDockerEnvToBash() {
  local usage="_return"
  local out err

  out=$(fileTemporaryName "$usage") || return $?
  err="$out.err"

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  decorate info "PWD is $(pwd)"
  if dockerEnvToBash "$home/test/example/test.env" >"$out" 2>"$err"; then
    __throwEnvironment "$usage" "dockerEnvToBash SHOULD fail" || return $?
  fi

  # Different than testDockerEnvToBashPipe
  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  # Different than testDockerEnvToBashPipe
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "test.env" "Invalid name" || return $?

  dockerEnvToBash "$home/test/example/docker.env" >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  __catchEnvironment "$usage" rm -f "$out" "$err" || return $?
}

# Same as above but this is a pipe
testDockerEnvToBashPipe() {
  local usage="_return"
  local out err

  out=$(fileTemporaryName "$usage") || return $?
  err="$out.err"

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  decorate info "PWD is $(pwd)"
  if dockerEnvToBash <"$home/test/example/test.env" >"$out" 2>"$err"; then
    __throwEnvironment "$usage" "dockerEnvToBash SHOULD fail" || return $?
  fi

  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  # Different than testDockerEnvToBash
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "Invalid name" || return $?
  # Different than testDockerEnvToBash
  assertFileDoesNotContain "$err" "test.env" || return $?

  dockerEnvToBash <"$home/test/example/docker.env" >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  __catchEnvironment "$usage" rm -f "$out" "$err" || return $?
}

testDockerEnvFromBash() {
  local usage="_return"
  local out err

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  assertExitCode --stderr-ok 2 dockerEnvFromBashEnv "$home/test/example/bad.env" || return $?

  assertExitCode --stdout-match "host=" --stdout-match "application=beanstalk" --stdout-match "uname=" 0 dockerEnvFromBashEnv "$home/test/example/bash.env" || return $?

  out=$(fileTemporaryName "$usage") || eturn $?
  err=$(fileTemporaryName "$usage") || return $?

  dockerEnvFromBashEnv "$home/test/example/bash.env" >"$out" 2>"$err" || return 1
  dumpPipe "ERRORS dockerEnvFromBashEnv $home/test/example/bash.env" <"$err"
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "today=" "uname=" || return $?

  __catchEnvironment "$usage" rm -f "$out" "$err" || return $?
}

testAnyEnvToDockerEnv() {
  local usage="_return"
  local testEnv

  testEnv=$(fileTemporaryName "$usage") || return $?

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  __environment anyEnvToDockerEnv "$testEnv" >"$testEnv.result" || return $?
  dumpPipe "Result - should be blank" <"$testEnv.result"
  assertExitCode 0 fileIsEmpty "$testEnv.result" || return $?

  __environment cp "$home/test/example/bash.env" "$testEnv" || return $?

  # mode 1
  __environment anyEnvToDockerEnv "$testEnv" >"$testEnv.result" || return $?
  # as a pipe
  __environment anyEnvToDockerEnv >"$testEnv.result2" <"$testEnv" || return $?
  assertExitCode --dump 0 diff -w "$testEnv.result2" "$testEnv.result" || return $?

  printf -- "%s=%s\n" "NAME" "\"value\"" >"$testEnv"
  assertExitCode --stdout-match 'NAME=value' 0 anyEnvToDockerEnv "$testEnv" || return $?

  rm -rf "$testEnv" "$testEnv.result" "$testEnv.result2"
}

testAnyEnvToBashEnv() {
  local usage="_return"
  local testEnv

  testEnv=$(fileTemporaryName "$usage") || return $?

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  __catchEnvironment "$usage" anyEnvToDockerEnv "$testEnv" >"$testEnv.result" || _environment "Failed @ $LINENO" || return $?
  __catchEnvironment "$usage" anyEnvToBashEnv "$testEnv" >"$testEnv.result" || _environment "Failed @ $LINENO" || return $?
  assertExitCode 0 fileIsEmpty "$testEnv.result" || return $?

  __catchEnvironment "$usage" cp "$home/test/example/docker.env" "$testEnv" || return $?

  __catchEnvironment "$usage" anyEnvToBashEnv "$testEnv" >"$testEnv.result" || return $?
  __catchEnvironment "$usage" anyEnvToBashEnv >"$testEnv.result2" <"$testEnv" || return $?

  assertExitCode 0 diff -w "$testEnv.result2" "$testEnv.result" || return $?

  __catchEnvironment "$usage" printf -- "%s=%s\n" "NAME" "\"value\"" >"$testEnv" || return $?
  assertExitCode --stdout-match 'NAME=value' 0 anyEnvToDockerEnv "$testEnv" || return $?

  __catchEnvironment "$usage" rm -f "$testEnv" "$testEnv.result" "$testEnv.result2" || return $?
}

testDotEnvCommentHandling() {
  local usage="_return"
  local testEnv home tab=$'\t'

  testEnv=$(fileTemporaryName "$usage") || return $?
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  __environment printf "%s\n" "# COMMENT=yes" "     # COMMENT_LEADING_SPACES=yes" "${tab}${tab}${tab}#${tab}COMMENT_LEADING_TABS=yes" "${tab} #${tab} COMMENT_LEADING_BOTH=yes" "BAZ=FIZ" "FIZZ=BUZZ" >"$testEnv" || return $?
  assertExitCode --stdout-match "COMMENT=yes" --stdout-match "COMMENT_LEADING_SPACES=yes" --stdout-match "COMMENT_LEADING_TABS=yes" --stdout-match "BAZ=\"FIZ\"" 0 dockerEnvToBash <"$testEnv" || return $?

  __catchEnvironment "$usage" rm -f "$testEnv" || return $?
}

testEnvCommentHandling() {
  local usage="_return"
  local testEnvBase home tab=$'\t' testFile testEnvBash

  testEnvBase=$(fileTemporaryName "$usage") || return $?
  testEnvBash="$testEnvBase.bash" || return $?
  testEnvDocker="$testEnvBase.docker" || return $?

  __catchEnvironment "$usage" printf -- "%s\n" "# Comment" "WORD=born" >"$testEnvDocker" || return $?
  __catchEnvironment "$usage" printf -- "%s\n" "# Comment" "WORD=\"born\"" >"$testEnvBash" || return $?

  assertExitCode 0 checkDockerEnvFile "$testEnvDocker" || return $?
  assertNotExitCode --stderr-match "WORD=\"born\"" 0 checkDockerEnvFile "$testEnvBash" || return $?

  for testFile in "$testEnvDocker" "$testEnvBash"; do
    #    statusMessage --last __echo anyEnvToBashEnv <"$testFile"
    #    statusMessage --last __echo anyEnvToDockerEnv <"$testFile"
    assertExitCode --stdout-match "WORD=\"born\"" --stdout-match "# Comment" 0 anyEnvToBashEnv "$testFile" || return $?
    assertExitCode --stdout-match "WORD=born" --stdout-no-match "# Comment" 0 anyEnvToDockerEnv "$testFile" || return $?
  done
  assertExitCode --stdout-match "WORD=\"born\"" --stdout-match "# Comment" 0 dockerEnvToBash "$testEnvDocker" || return $?
  assertExitCode --stdout-match "WORD=born" --stdout-no-match "# Comment" 0 dockerEnvFromBashEnv "$testEnvBash" || return $?

  __catchEnvironment "$usage" rm -rf "$testEnvBase" "$testEnvDocker" "$testEnvBash" || return $?
}
