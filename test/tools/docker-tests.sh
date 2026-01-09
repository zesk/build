#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# docker-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testCheckDockerEnvFile() {
  local handler="returnMessage"
  local out home

  home=$(catchReturn "$handler" buildHome) || return $?

  local testFile="$home/test/example/bad.env"

  assertExitCode --stderr-ok 1 environmentFileIsDocker "$testFile" || return $?
  assertExitCode --stderr-match TEST_AWS_SECURITY_GROUP 1 environmentFileIsDocker "$testFile" || return $?
  assertExitCode --stderr-match DOLLAR 1 environmentFileIsDocker "$testFile" || return $?
  assertExitCode --stderr-no-match GOOD 1 environmentFileIsDocker "$testFile" || return $?
  assertExitCode --stderr-no-match HELLO 1 environmentFileIsDocker "$testFile" || return $?

  assertExitCode 0 environmentFileDockerToBashCompatible "$testFile" || return $?

  out=$(catchEnvironment "$handler" fileTemporaryName "$handler") || return $?

  catchReturn "$handler" environmentFileDockerToBashCompatible "$testFile" >"$out" || return $?
  assertFileContains "$out" '\"quotes\"' TEST_AWS_SECURITY_GROUP "DOLLAR=" "QUOTE=" "GOOD=" 'HELLO="W' || return $?
  catchEnvironment "$handler" rm "$out" || return $?
}

testEnvironmentFileDockerToBashCompatible() {
  local handler="returnMessage"
  local out err

  out=$(fileTemporaryName "$handler") || return $?
  err="$out.err"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  local exitCode

  decorate info "PWD is $(pwd)"
  catchEnvironment "$handler" environmentFileDockerToBashCompatible "$home/test/example/test.env" >"$out" 2>"$err" || exitCode=$?

  assertNotEquals "0" "$exitCode" || return $?

  # Different than testEnvironmentFileDockerToBashCompatiblePipe
  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  # Different than testEnvironmentFileDockerToBashCompatiblePipe
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "test.env" "Invalid name" || return $?

  environmentFileDockerToBashCompatible "$home/test/example/docker.env" >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  catchEnvironment "$handler" rm -f "$out" "$err" || return $?
}

# Same as above but this is a pipe
testEnvironmentFileDockerToBashCompatiblePipe() {
  local handler="returnMessage"
  local out err

  out=$(fileTemporaryName "$handler") || return $?
  err="$out.err"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  decorate info "PWD is $(pwd)"
  if environmentFileDockerToBashCompatible <"$home/test/example/test.env" >"$out" 2>"$err"; then
    throwEnvironment "$handler" "environmentFileDockerToBashCompatible SHOULD fail" || return $?
  fi

  assertFileContains "$out" "A=" "ABC=" "ABC_D=" "A01234=" "a=" "abc=" "abc_d=" || return $?
  # Different than testEnvironmentFileDockerToBashCompatible
  assertFileContains "$err" "01234" "+A" "*A" "+a" "*a" "?a" "Invalid name" || return $?
  # Different than testEnvironmentFileDockerToBashCompatible
  assertFileDoesNotContain "$err" "test.env" || return $?

  environmentFileDockerToBashCompatible <"$home/test/example/docker.env" >"$out" 2>"$err" || return $?
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "application=\"golden goose\"" "uname=\"localhost\"" "location=" || return $?

  catchEnvironment "$handler" rm -f "$out" "$err" || return $?
}

testDockerEnvFromBash() {
  local handler="returnMessage"
  local out err

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  assertExitCode --stderr-ok 2 environmentFileBashCompatibleToDocker "$home/test/example/bad.env" || return $?

  assertExitCode --stdout-match "host=" --stdout-match "application=beanstalk" --stdout-match "uname=" 0 environmentFileBashCompatibleToDocker "$home/test/example/bash.env" || return $?

  out=$(fileTemporaryName "$handler") || eturn $?
  err=$(fileTemporaryName "$handler") || return $?

  environmentFileBashCompatibleToDocker "$home/test/example/bash.env" >"$out" 2>"$err" || return 1
  dumpPipe "ERRORS environmentFileBashCompatibleToDocker $home/test/example/bash.env" <"$err"
  assertEquals 0 "$(fileSize "$err")" || return $?
  assertFileContains "$out" "host=" "today=" "uname=" || return $?

  catchEnvironment "$handler" rm -f "$out" "$err" || return $?
}

testEnvironmentFileToDocker() {
  local handler="returnMessage"
  local testEnv

  testEnv=$(fileTemporaryName "$handler") || return $?

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  catchReturn "$handler" environmentFileToDocker "$testEnv" >"$testEnv.result" || return $?
  dumpPipe "Result - should be blank" <"$testEnv.result"
  assertExitCode 0 fileIsEmpty "$testEnv.result" || return $?

  catchEnvironment "$handler" cp "$home/test/example/bash.env" "$testEnv" || return $?

  # mode 1
  catchReturn "$handler" environmentFileToDocker "$testEnv" >"$testEnv.result" || return $?
  # as a pipe
  catchReturn "$handler" environmentFileToDocker >"$testEnv.result2" <"$testEnv" || return $?
  assertExitCode --dump 0 diff -w "$testEnv.result2" "$testEnv.result" || return $?

  printf -- "%s=%s\n" "NAME" "\"value\"" >"$testEnv"
  assertExitCode --stdout-match 'NAME=value' 0 environmentFileToDocker "$testEnv" || return $?

  rm -rf "$testEnv" "$testEnv.result" "$testEnv.result2"
}

testAnyEnvToBashEnv() {
  local handler="returnMessage"
  local testEnv

  testEnv=$(fileTemporaryName "$handler") || return $?

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  catchReturn "$handler" environmentFileToDocker "$testEnv" >"$testEnv.result" || returnEnvironment "Failed @ $LINENO" || return $?
  catchReturn "$handler" environmentFileToBashCompatible "$testEnv" >"$testEnv.result" || returnEnvironment "Failed @ $LINENO" || return $?
  assertExitCode 0 fileIsEmpty "$testEnv.result" || return $?

  catchEnvironment "$handler" cp "$home/test/example/docker.env" "$testEnv" || return $?

  catchReturn "$handler" environmentFileToBashCompatible "$testEnv" >"$testEnv.result" || return $?
  catchReturn "$handler" environmentFileToBashCompatible >"$testEnv.result2" <"$testEnv" || return $?

  assertExitCode 0 diff -w "$testEnv.result2" "$testEnv.result" || return $?

  catchEnvironment "$handler" printf -- "%s=%s\n" "NAME" "\"value\"" >"$testEnv" || return $?
  assertExitCode --stdout-match 'NAME=value' 0 environmentFileToDocker "$testEnv" || return $?

  catchEnvironment "$handler" rm -f "$testEnv" "$testEnv.result" "$testEnv.result2" || return $?
}

testDotEnvCommentHandling() {
  local handler="returnMessage"
  local testEnv home tab=$'\t'

  testEnv=$(fileTemporaryName "$handler") || return $?
  home=$(catchReturn "$handler" buildHome) || return $?

  catchEnvironment "$handler" printf "%s\n" "# COMMENT=yes" "     # COMMENT_LEADING_SPACES=yes" "${tab}${tab}${tab}#${tab}COMMENT_LEADING_TABS=yes" "${tab} #${tab} COMMENT_LEADING_BOTH=yes" "BAZ=FIZ" "FIZZ=BUZZ" >"$testEnv" || return $?
  assertExitCode --stdout-match "COMMENT=yes" --stdout-match "COMMENT_LEADING_SPACES=yes" --stdout-match "COMMENT_LEADING_TABS=yes" --stdout-match "BAZ=\"FIZ\"" 0 environmentFileDockerToBashCompatible <"$testEnv" || return $?

  catchEnvironment "$handler" rm -f "$testEnv" || return $?
}

testEnvCommentHandling() {
  local handler="returnMessage"
  local testEnvBase home tab=$'\t' testFile testEnvBash testEnvDocker

  testEnvBase=$(fileTemporaryName "$handler") || return $?
  testEnvBash="$testEnvBase.bash" || return $?
  testEnvDocker="$testEnvBase.docker" || return $?

  catchEnvironment "$handler" printf -- "%s\n" "# Comment" "WORD=born" >"$testEnvDocker" || return $?
  catchEnvironment "$handler" printf -- "%s\n" "# Comment" "WORD=\"born\"" >"$testEnvBash" || return $?

  assertExitCode 0 environmentFileIsDocker "$testEnvDocker" || return $?
  assertNotExitCode --stderr-match "WORD=\"born\"" 0 environmentFileIsDocker "$testEnvBash" || return $?

  for testFile in "$testEnvDocker" "$testEnvBash"; do
    assertExitCode --stdout-match "WORD=\"born\"" --stdout-match "# Comment" 0 environmentFileToBashCompatible "$testFile" || return $?
    assertExitCode --stdout-match "WORD=born" --stdout-no-match "# Comment" 0 environmentFileToDocker "$testFile" || return $?
  done
  assertExitCode --stdout-match "WORD=\"born\"" --stdout-match "# Comment" 0 environmentFileDockerToBashCompatible "$testEnvDocker" || return $?
  assertExitCode --stdout-match "WORD=born" --stdout-no-match "# Comment" 0 environmentFileBashCompatibleToDocker "$testEnvBash" || return $?

  catchEnvironment "$handler" rm -rf "$testEnvBase" "$testEnvDocker" "$testEnvBash" || return $?
}
