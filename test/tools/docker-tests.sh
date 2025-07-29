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

  home=$(__catch "$usage" buildHome) || return $?

  local testFile="$home/test/example/bad.env"

  assertExitCode --stderr-ok 1 environmentFileIsDocker "$testFile" || return $?
  assertExitCode --stderr-match TEST_AWS_SECURITY_GROUP 1 environmentFileIsDocker "$testFile" || return $?
  assertExitCode --stderr-match DOLLAR 1 environmentFileIsDocker "$testFile" || return $?
  assertExitCode --stderr-no-match GOOD 1 environmentFileIsDocker "$testFile" || return $?
  assertExitCode --stderr-no-match HELLO 1 environmentFileIsDocker "$testFile" || return $?

  assertExitCode 0 environmentFileDockerToBashCompatible "$testFile" || return $?

  out=$(__catchEnvironment "$usage" fileTemporaryName "$usage") || return $?

  __catch "$usage" environmentFileDockerToBashCompatible "$testFile" >"$out" || return $?
  assertFileContains "$out" '\"quotes\"' TEST_AWS_SECURITY_GROUP "DOLLAR=" "QUOTE=" "GOOD=" 'HELLO="W' || return $?
  __catchEnvironment "$usage" rm "$out" || return $?
}

testEnvironmentFileDockerToBashCompatible() {
  local usage="_return"
  local out err

  out=$(fileTemporaryName "$usage") || return $?
  err="$out.err"

  local home
  home=$(__catch "$usage" buildHome) || return $?

  decorate info "PWD is $(pwd)"
  if environmentFileDockerToBashCompatible "$home/test/example/test.env" >"$out" 2>"$err"; then
    __throwEnvironment "$usage" "environmentFileDockerToBashCompatible SHOULD fail" || return $?
  fi

  # Different than testEnvironmentFileDockerToBashCompatiblePipe
  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  # Different than testEnvironmentFileDockerToBashCompatiblePipe
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "test.env" "Invalid name" || return $?

  environmentFileDockerToBashCompatible "$home/test/example/docker.env" >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  __catchEnvironment "$usage" rm -f "$out" "$err" || return $?
}

# Same as above but this is a pipe
testEnvironmentFileDockerToBashCompatiblePipe() {
  local usage="_return"
  local out err

  out=$(fileTemporaryName "$usage") || return $?
  err="$out.err"

  local home
  home=$(__catch "$usage" buildHome) || return $?

  decorate info "PWD is $(pwd)"
  if environmentFileDockerToBashCompatible <"$home/test/example/test.env" >"$out" 2>"$err"; then
    __throwEnvironment "$usage" "environmentFileDockerToBashCompatible SHOULD fail" || return $?
  fi

  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  # Different than testEnvironmentFileDockerToBashCompatible
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "Invalid name" || return $?
  # Different than testEnvironmentFileDockerToBashCompatible
  assertFileDoesNotContain "$err" "test.env" || return $?

  environmentFileDockerToBashCompatible <"$home/test/example/docker.env" >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  __catchEnvironment "$usage" rm -f "$out" "$err" || return $?
}

testDockerEnvFromBash() {
  local usage="_return"
  local out err

  local home
  home=$(__catch "$usage" buildHome) || return $?

  assertExitCode --stderr-ok 2 environmentFileBashCompatibleToDocker "$home/test/example/bad.env" || return $?

  assertExitCode --stdout-match "host=" --stdout-match "application=beanstalk" --stdout-match "uname=" 0 environmentFileBashCompatibleToDocker "$home/test/example/bash.env" || return $?

  out=$(fileTemporaryName "$usage") || eturn $?
  err=$(fileTemporaryName "$usage") || return $?

  environmentFileBashCompatibleToDocker "$home/test/example/bash.env" >"$out" 2>"$err" || return 1
  dumpPipe "ERRORS environmentFileBashCompatibleToDocker $home/test/example/bash.env" <"$err"
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "today=" "uname=" || return $?

  __catchEnvironment "$usage" rm -f "$out" "$err" || return $?
}

testEnvironmentFileToDocker() {
  local usage="_return"
  local testEnv

  testEnv=$(fileTemporaryName "$usage") || return $?

  local home
  home=$(__catch "$usage" buildHome) || return $?

  __environment environmentFileToDocker "$testEnv" >"$testEnv.result" || return $?
  dumpPipe "Result - should be blank" <"$testEnv.result"
  assertExitCode 0 fileIsEmpty "$testEnv.result" || return $?

  __environment cp "$home/test/example/bash.env" "$testEnv" || return $?

  # mode 1
  __environment environmentFileToDocker "$testEnv" >"$testEnv.result" || return $?
  # as a pipe
  __environment environmentFileToDocker >"$testEnv.result2" <"$testEnv" || return $?
  assertExitCode --dump 0 diff -w "$testEnv.result2" "$testEnv.result" || return $?

  printf -- "%s=%s\n" "NAME" "\"value\"" >"$testEnv"
  assertExitCode --stdout-match 'NAME=value' 0 environmentFileToDocker "$testEnv" || return $?

  rm -rf "$testEnv" "$testEnv.result" "$testEnv.result2"
}

testAnyEnvToBashEnv() {
  local usage="_return"
  local testEnv

  testEnv=$(fileTemporaryName "$usage") || return $?

  local home
  home=$(__catch "$usage" buildHome) || return $?

  __catch "$usage" environmentFileToDocker "$testEnv" >"$testEnv.result" || _environment "Failed @ $LINENO" || return $?
  __catch "$usage" environmentFileToBashCompatible "$testEnv" >"$testEnv.result" || _environment "Failed @ $LINENO" || return $?
  assertExitCode 0 fileIsEmpty "$testEnv.result" || return $?

  __catchEnvironment "$usage" cp "$home/test/example/docker.env" "$testEnv" || return $?

  __catch "$usage" environmentFileToBashCompatible "$testEnv" >"$testEnv.result" || return $?
  __catch "$usage" environmentFileToBashCompatible >"$testEnv.result2" <"$testEnv" || return $?

  assertExitCode 0 diff -w "$testEnv.result2" "$testEnv.result" || return $?

  __catchEnvironment "$usage" printf -- "%s=%s\n" "NAME" "\"value\"" >"$testEnv" || return $?
  assertExitCode --stdout-match 'NAME=value' 0 environmentFileToDocker "$testEnv" || return $?

  __catchEnvironment "$usage" rm -f "$testEnv" "$testEnv.result" "$testEnv.result2" || return $?
}

testDotEnvCommentHandling() {
  local usage="_return"
  local testEnv home tab=$'\t'

  testEnv=$(fileTemporaryName "$usage") || return $?
  home=$(__catch "$usage" buildHome) || return $?

  __environment printf "%s\n" "# COMMENT=yes" "     # COMMENT_LEADING_SPACES=yes" "${tab}${tab}${tab}#${tab}COMMENT_LEADING_TABS=yes" "${tab} #${tab} COMMENT_LEADING_BOTH=yes" "BAZ=FIZ" "FIZZ=BUZZ" >"$testEnv" || return $?
  assertExitCode --stdout-match "COMMENT=yes" --stdout-match "COMMENT_LEADING_SPACES=yes" --stdout-match "COMMENT_LEADING_TABS=yes" --stdout-match "BAZ=\"FIZ\"" 0 environmentFileDockerToBashCompatible <"$testEnv" || return $?

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

  assertExitCode 0 environmentFileIsDocker "$testEnvDocker" || return $?
  assertNotExitCode --stderr-match "WORD=\"born\"" 0 environmentFileIsDocker "$testEnvBash" || return $?

  for testFile in "$testEnvDocker" "$testEnvBash"; do
    assertExitCode --stdout-match "WORD=\"born\"" --stdout-match "# Comment" 0 environmentFileToBashCompatible "$testFile" || return $?
    assertExitCode --stdout-match "WORD=born" --stdout-no-match "# Comment" 0 environmentFileToDocker "$testFile" || return $?
  done
  assertExitCode --stdout-match "WORD=\"born\"" --stdout-match "# Comment" 0 environmentFileDockerToBashCompatible "$testEnvDocker" || return $?
  assertExitCode --stdout-match "WORD=born" --stdout-no-match "# Comment" 0 environmentFileBashCompatibleToDocker "$testEnvBash" || return $?

  __catchEnvironment "$usage" rm -rf "$testEnvBase" "$testEnvDocker" "$testEnvBash" || return $?
}
