#!/bin/bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

errorEnvironment=1
errorArgument=2
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

#
# Usage: {fn} [ --show ] [ --verbose ] [ --keep ]
# Argument: --show - Optional. Flag. Print the displayed test crontab file to stdout.
# Argument: --verbose - Optional. Flag. Be chatty.
# Argument: --keep - Optional. Flag. Do not delete artifacts when done, print created values.
#
testPHPBuild() {
  local keepFlag testPath here appName f

  keepFlag=
  while [ $# -gt 0 ]; do
    case $1 in
      --clean)
        statusMessage consoleWarning "Cleaning ..."
        for f in vendor .composer; do
          rm -rf "./test/tools/example/simple-php/$f" 2>/dev/null
        done
        ;;
      --keep)
        keepFlag=1
        echo "Keeping test artifacts" 1>&2
        ;;
      *)
        if [ -d "$1" ]; then
          echo "Home is $1"
        else
          _testPHPBuild $errorArgument "No arguments"
        fi
        ;;
    esac
    shift
  done

  here=$(pwd)

  #
  # This MUST be inside the source tree root to run docker in pipelines
  #
  testPath="$(randomString)"
  testPath="${testPath:0:8}"
  testPath="$here/.testPHPBuild.$testPath"
  if ! mkdir -p "$testPath"; then
    consoleError "Unable to create $testPath, exiting"
    return $errorEnvironment
  fi
  appName="sublimeApplication"

  if ! cp -r ./test/example/simple-php "$testPath/$appName"; then
    consoleError "Failed copy app"
    return $errorEnvironment
  fi
  echo "PWD: $(pwd)"

  # shellcheck source=/dev/null
  . ./bin/build/env/BUILD_TARGET.sh
  # shellcheck source=/dev/null
  . ./bin/build/env/BUILD_TIMESTAMP.sh

  assertEquals "${BUILD_TARGET}" "app.tar.gz"

  mkdir -p "$testPath/$appName/bin/pipeline" || return $errorEnvironment
  cp ./bin/build/install-bin-build.sh "$testPath/$appName/bin/pipeline/install-bin-build.sh" || return $errorEnvironment

  here=$(pwd)

  set +x
  consoleInfo "Test build directory is: $testPath"

  cd "$testPath/$appName"
  assertFileDoesNotExist "./app.tar.gz"
  assertDirectoryDoesNotExist bin/build

  assertFileExists ./bin/pipeline/install-bin-build.sh

  ./bin/pipeline/install-bin-build.sh --mock "$here/bin/build"
  assertDirectoryExists bin/build

  consoleWarning "Building PHP app"

  assertEquals "${BUILD_TARGET}" "app.tar.gz"

  # No environment
  bin/build.sh || return $?
  assertFileExists "./app.tar.gz" "pwd: $(pwd)" || return $?
  rm ./app.tar.gz || :

  export APP_THING=secret

  # Add an environment
  bin/build.sh APP_THING || return $?
  assertFileExists "./app.tar.gz" "pwd: $(pwd)" || return $?

  BUILD_TARGET=alternate.tar.gz
  bin/build.sh || return $?
  assertFileExists "$BUILD_TARGET" "pwd: $(pwd)" || return $?

  mkdir ./compare-app || return $?
  mkdir ./compare-alternate || return $?
  cd ./compare-app || return $?
  tar xf ../app.tar.gz || return $?
  # Vendor has random numbers in the classnames
  rm -rf ./vendor || return $?
  cd .. || return $?

  cd ./compare-alternate || return $?
  tar xf ../alternate.tar.gz || return $?
  rm -rf ./vendor || return $?
  cd .. || return $?

  if ! diff -r ./compare-app ./compare-alternate; then
    consoleError "Directories differ - failed"
    return $?
  fi

  manifest=$(mktemp) || return $?
  tar tf app.tar.gz >"$manifest.complete" || return $?
  grep -v 'vendor/' "$manifest.complete" >"$manifest" || return $?
  assertFileContains "$manifest" .deploy .deploy/APPLICATION_ID .deploy/APPLICATION_TAG simple.application.php src/Application.php .env
  assertFileDoesNotContain "$manifest" composer.lock composer.json bitbucket-pipelines.yml
  assertFileContains "$manifest.complete" vendor/zesk vendor/composer

  if ! test "$keepFlag"; then
    consoleWarning Deleting app.tar.gz "$BUILD_TARGET" || :
    rm app.tar.gz "$BUILD_TARGET" || :
    cd "$here" || :
    rm -rf ./compare-app ./compare-alternate "$manifest.complete" "$manifest" ./.testPHPBuild.*
  fi
  cd "$here" || :
  consoleSuccess Passed.
}
_testPHPBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

testPHPBuild "$@"
