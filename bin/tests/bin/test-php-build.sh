#!/bin/bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

errorEnvironment=1
errorArgument=2
me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

_testPHPBuildUsage() {
  usageDocument "bin/tests/bin/$me" testPHPBuild
}
#
# Argument: --show - Print the displayed test crontab file to stdout
# Argument: --verbose - Be chatty
# Argument: --keep - Do not delete artifacts when done, print created values
#
testPHPBuild() {
  local keepFlag testPath here

  keepFlag=
  while [ $# -gt 0 ]; do
    case $1 in
      --clean)
        statusMessage consoleWarning "Cleaning ..."
        for f in vendor .composer; do
          rm -rf "./bin/tests/example/simple-php/$f" 2>/dev/null
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
          _testPHPBuildUsage $errorArgument "No arguments"
        fi
        ;;
    esac
    shift
  done

  testPath=$(mktemp -d)
  appName="sublimeApplication"

  if ! cp -r ./bin/tests/example/simple-php "$testPath/$appName"; then
    consoleError "Failed copy app"
    return $errorEnvironment
  fi

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
  export BUILD_TIMESTAMP

  BUILD_TIMESTAMP=$(date +%s)
  bin/build.sh
  assertFileExists "./app.tar.gz"
  export BUILD_TARGET=alternate.tar.gz
  bin/build.sh
  assertFileExists "$BUILD_TARGET"

  assertEquals "$(shaPipe app.tar.gz)" "$(shaPipe "$BUILD_TARGET")" "checksums do not match"

  manifest=$(mktemp)
  tar tf app.tar.gz >"$manifest"
  assertFileContains "$manifest" .deploy .deploy/APPLICATION_CHECKSUM .deploy/APPLICATION_TAG simple.application.php vendor/zesk vendor/composer src/Application.php .env
  assertFileDoesNotContain "$manifest" composer.lock composer.json bitbucket-pipelines.yml

  if ! test $keepFlag; then
    rm app.tar.gz "$BUILD_TARGET"
  fi
  consoleSuccess Passed.
}

testPHPBuild "$@"
