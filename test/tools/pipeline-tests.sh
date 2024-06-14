#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

declare -a tests

tests+=(testDotEnvConfigure)
testDotEnvConfigure() {
  local tempDir="$$.dotEnvConfig"
  mkdir "$tempDir"
  cd "$tempDir" || return "$errorEnvironment"
  consoleInfo "$(pwd)"
  touch .env
  if ! dotEnvConfigure; then
    consoleError "dotEnvConfigure failed with just .env"
    return "$errorEnvironment"
  fi
  touch .env.local
  if ! dotEnvConfigure; then
    consoleError "dotEnvConfigure failed with both .env"
    return "$errorEnvironment"
  fi
  cd .. || return $?
  rm -rf "$tempDir" || return $?
  consoleSuccess dotEnvConfigure works AOK
}

tests+=(testMakeEnvironment)
testMakeEnvironment() {
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
    makeEnvironment TESTING_ENV DSN >.env || return $?

    if [ ! -f .env ]; then
      consoleError "make-env.sh did not generate a .env file"
      return "$errorEnvironment"
    fi
    for v in TESTING_ENV APPLICATION_BUILD_DATE APPLICATION_VERSION DSN; do
      if ! grep -q "$v" .env; then
        consoleError "makeEnvironment > .env file does not contain $v"
        wrapLines "$(consoleCode)    " "$(consoleReset)" <.env
        return "$errorEnvironment"
      fi
    done
    consoleGreen make-env.sh works AOK
    rm .env
  )
}
