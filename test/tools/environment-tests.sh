#!/usr/bin/env bash
#
# environment-tests.sh
#
# Environment tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testDotEnvConfigure() {
  local tempDir tempEnv magic
  export TESTENVWORKS TESTENVLOCALWORKS

  magic=$(randomString)
  tempDir="$(__environment buildCacheDirectory)/$$.dotEnvConfig" || return $?

  __environment mkdir -p "$tempDir" || return $?
  __environment cd "$tempDir" || return $?
  consoleInfo "$(pwd)"
  assertNotExitCode --line "$LINENO" --stderr-match "Missing" 0 dotEnvConfigure || return $?

  tempEnv="$tempDir/.env"
  __environment touch "$tempEnv" || return $?
  __environment environmentValueWrite TESTENVWORKS "$magic" >>"$tempEnv" || return $?

  assertEquals --line "$LINENO" "" "${TESTENVWORKS-}" || return $?
  assertEquals --line "$LINENO" "" "${TESTENVLOCALWORKS-}" || return $?

  dotEnvConfigure "$tempDir" || return $?
  assertExitCode --line "$LINENO" 0 dotEnvConfigure "$tempDir" || return $?

  assertEquals --line "$LINENO" "$magic" "${TESTENVWORKS-}" || return $?
  assertEquals --line "$LINENO" "" "${TESTENVLOCALWORKS-}" || return $?

  __environment environmentValueWrite TESTENVLOCALWORKS "$magic" >>"$tempEnv" || return $?
  __environment environmentValueWrite TESTENVWORKS "NEW-$magic" >>"$tempEnv" || return $?
  __environment touch .env.local || return $?

  dotEnvConfigure "$tempDir" || return $?
  assertExitCode --line "$LINENO" 0 dotEnvConfigure "$tempDir" || return $?

  assertEquals --line "$LINENO" "NEW-$magic" "${TESTENVWORKS-}" || return $?
  assertEquals --line "$LINENO" "$magic" "${TESTENVLOCALWORKS-}" || return $?

  __environment cd .. || return $?
  __environment rm -rf "$tempDir" || return $?
  consoleSuccess dotEnvConfigure works AOK

  unset TESTENVWORKS TESTENVLOCALWORKS
}

testEnvironmentFileLoad() {
  local tempDir
  export TESTVAR

  tempDir="$(__environment buildCacheDirectory)/$$.${FUNCNAME[0]}" || return $?

  __environment mkdir -p "$tempDir" || return $?
  __environment cd "$tempDir" || return $?
  assertNotExitCode --stderr-match "is not file" --line "$LINENO" 0 environmentFileLoad .env || return $?

  touch .env
  assertExitCode --line "$LINENO" 0 environmentFileLoad .env || return $?
  assertEquals --line "$LINENO" "${TESTVAR-}" "" || return $?

  __environment touch .env.local || return $?
  assertExitCode 0 dotEnvConfigure || _environment "dotEnvConfigure failed with both .env" || return $?
  __environment cd .. || return $?
  __environment rm -rf "$tempDir" || return $?
  consoleSuccess dotEnvConfigure works AOK
}

testEnvironmentFileMake() {
  local v
  (
    set -eou pipefail

    export TESTING_ENV=chameleon
    export DSN=mysql://not@host/thing

    export DEPLOY_USER_HOSTS=none
    export BUILD_TARGET=app2.tar.gz
    export DEPLOYMENT=test-application-environment
    export APPLICATION_ID=aabbccdd

    [ ! -f .env ] || rm .env
    environmentFileApplicationMake TESTING_ENV DSN >.env || return $?

    if [ ! -f .env ]; then
      _environment "environmentFileApplicationMake did not generate a .env file" || return $?
    fi
    for v in TESTING_ENV APPLICATION_BUILD_DATE APPLICATION_VERSION DSN; do
      if ! grep -q "$v" .env; then
        _environment "$(printf -- "%s %s\n%s" "environmentFileApplicationMake > .env file does not contain" "$(consoleCode "$v")" "$(wrapLines "$(consoleCode)    " "$(consoleReset)" <.env)")" || return $?
      fi
    done
    consoleGreen application-environment.sh works AOK
    rm .env
  )
}

testEnvironmentVariables() {
  local e
  e=$(mktemp)
  export BUILD_TEST_UNIQUE=1
  if ! environmentVariables >"$e"; then
    consoleError environmentVariables failed
    return 1
  fi
  assertFileContains --line "$LINENO" "$e" BUILD_TEST_UNIQUE HOME PATH PWD TERM SHLVL || return $?
  wrapLines "environmentVariables: $(consoleCode)" "$(consoleReset)" <"$e"
  rm "$e"

  unset BUILD_TEST_UNIQUE
}

__testEnvironmentValueReadWriteData() {
  cat <<'EOF'
hello This is a test
world Earth
argumentIndex 0
EOF
}

testEnvironmentValueReadWrite() {
  local foo

  foo=$(__environment mktemp) || return $?

  __testEnvironmentValueReadWriteData | while read -r testName testValue; do
    __environment environmentValueWrite "$testName" "$testValue" >>"$foo" || return $?
    value=$(__environment environmentValueRead "$foo" "$testName" "*default*") || return $?
    assertEquals --line "$LINENO" "$testValue" "$value" "Read write value changed" || return $?
  done
}
