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
  __environment mkdir -p "$testPath" || return $?
  appName="sublimeApplication"

  __environment cp -r ./test/example/simple-php "$testPath/$appName" || return $?
  echo "PWD: $(pwd)"

  buildEnvironmentLoad BUILD_TARGET BUILD_TIMESTAMP

  assertEquals "${BUILD_TARGET}" "app.tar.gz" || return $?

  __environment mkdir -p "$testPath/$appName/bin" || return $?
  __environment installInstallBuild "$testPath/$appName/bin" "$testPath/$appName" || return $?

  here=$(pwd) || _environment pwd || return $?

  consoleInfo "Test build directory is: $testPath" || :

  __environment cd "$testPath/$appName" || return $?
  assertFileDoesNotExist "./app.tar.gz" || return $?
  assertDirectoryDoesNotExist bin/build || return $?

  assertFileExists ./bin/install-bin-build.sh || return $?

  ./bin/install-bin-build.sh --mock "$here/bin/build" || return $?
  assertDirectoryExists bin/build || return $?

  consoleWarning "Building PHP app" || :

  assertEquals "${BUILD_TARGET}" "app.tar.gz" || return $?

  printf "\n"
  # No environment
  bin/build.sh || return $?
  assertFileExists "./app.tar.gz" "pwd: $(pwd)" || return $?
  rm ./app.tar.gz || return $?

  export APP_THING=secret

  # Add an environment
  printf "\n"
  bin/build.sh APP_THING || return $?
  assertFileExists "./app.tar.gz" "pwd: $(pwd)" || return $?

  BUILD_TARGET=alternate.tar.gz
  printf "\n"
  bin/build.sh || return $?
  assertFileExists "$BUILD_TARGET" "pwd: $(pwd)" || return $?

  mkdir ./compare-app || return $?
  mkdir ./compare-alternate || return $?
  cd ./compare-app || return $?

  consoleInfo "Extracting app.tar.gz ... "
  tar xf ../app.tar.gz || return $?
  # Vendor has random numbers in the classnames
  rm -rf ./vendor || return $?
  cd .. || return $?

  cd ./compare-alternate || return $?

  consoleInfo "Extracting alternate.tar.gz ... "
  tar xf ../alternate.tar.gz || return $?
  rm -rf ./vendor || return $?
  cd .. || return $?

  if ! assertOutputContains --exit 1 'APP_THING="secret"' diff -r ./compare-app ./compare-alternate; then
    consoleError "MISSING changes in app"
    return $errorEnvironment
  fi

  manifest=$(mktemp) || return $?

  consoleInfo "Extracting app.tar.gz manifest ... "
  tar tf app.tar.gz >"$manifest.complete" || return $?
  grep -v 'vendor/' "$manifest.complete" >"$manifest" || return $?
  assertFileContains "$manifest" .deploy .deploy/APPLICATION_ID .deploy/APPLICATION_TAG simple.application.php src/Application.php .env || return $?
  assertFileDoesNotContain "$manifest" composer.lock composer.json bitbucket-pipelines.yml || return $?
  assertFileContains "$manifest.complete" vendor/zesk vendor/composer || return $?

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
