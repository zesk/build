#!/usr/bin/env bash
#
# environment-tests.sh
#
# Environment tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

tests+=(testDotEnvConfigure)
tests+=(testDotEnvConfigure)
tests+=(testEnvironmentFileMake)
tests+=(testEnvironmentVariables)

testDotEnvConfigure() {
  local tempDir
  export TESTENVWORKS TESTENVLOCALWORKS

  magic=$(randomString)
  tempDir="$(__environment buildCacheDirectory)/$$.dotEnvConfig" || return $?

  __environment mkdir -p "$tempDir" || return $?
  __environment cd "$tempDir" || return $?
  consoleInfo "$(pwd)"
  assertNotExitCode 0 dotEnvConfigure || return $?

  __environment touch .env || return $?
  __environment environmentWriteValue TESTENVWORKS "$magic" >>.env || return $?

  assertEquals "" "${TESTENVWORKS-}" || return $?
  assertEquals "" "${TESTENVLOCALWORKS-}" || return $?

  assertExitCode 0 dotEnvConfigure || return $?

  assertEquals "$magic" "${TESTENVWORKS-}" || return $?
  assertEquals "" "${TESTENVLOCALWORKS-}" || return $?

  environmentWriteValue TESTENVWORKS "NEW-$magic" >>.env || return $?
  __environment touch .env.local || return $?

  assertExitCode 0 dotEnvConfigure || return $?

  assertEquals "NEW-$magic" "${TESTENVWORKS-}" || return $?
  assertEquals "$magic" "${TESTENVLOCALWORKS-}" || return $?

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
  assertNotExitCode 0 environmentFileLoad .env || return $?
  touch .env
  assertExitCode 0 environmentFileLoad .env || return $?
  assertEquals "${TESTVAR-}" "" || return $?
  environmentWriteValue

  __environment touch .env.local || return $?
  if ! dotEnvConfigure; then
    _environment "dotEnvConfigure failed with both .env" || return $?
  fi
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
    export DEPLOYMENT=test-make-env
    export APPLICATION_ID=aabbccdd

    [ ! -f .env ] || rm .env
    environmentFileApplicationMake TESTING_ENV DSN >.env || return $?

    if [ ! -f .env ]; then
      _environment "make-env.sh did not generate a .env file" || return $?
    fi
    for v in TESTING_ENV APPLICATION_BUILD_DATE APPLICATION_VERSION DSN; do
      if ! grep -q "$v" .env; then
        _environment "$(printf -- "%s %s\n%s" "environmentFileApplicationMake > .env file does not contain" "$(consoleCode "$v")" "$(wrapLines "$(consoleCode)    " "$(consoleReset)" <.env)")" || return $?
      fi
    done
    consoleGreen make-env.sh works AOK
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
