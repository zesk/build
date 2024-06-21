#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

tests+=(testDotEnvConfigure)
testDotEnvConfigure() {
  local tempDir="$$.dotEnvConfig"
  mkdir "$tempDir"
  __environment cd "$tempDir" || return $?
  consoleInfo "$(pwd)"
  touch .env
  if ! dotEnvConfigure; then
    _environment "dotEnvConfigure failed with just .env" || return $?
  fi
  touch .env.local
  if ! dotEnvConfigure; then
    _environment "dotEnvConfigure failed with both .env" || return $?
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
      _environment "make-env.sh did not generate a .env file" || return $?
    fi
    for v in TESTING_ENV APPLICATION_BUILD_DATE APPLICATION_VERSION DSN; do
      if ! grep -q "$v" .env; then
        _environment "$(printf -- "%s %s\n%s" "makeEnvironment > .env file does not contain" "$(consoleCode "$v")" "$(wrapLines "$(consoleCode)    " "$(consoleReset)" <.env)")" || return $?
      fi
    done
    consoleGreen make-env.sh works AOK
    rm .env
  )
}
