#!/usr/bin/env bash
#
# php-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testPHPBuild)

#
# Usage: {fn} [ --show ] [ --verbose ] [ --keep ]
# Argument: --show - Optional. Flag. Print the displayed test crontab file to stdout.
# Argument: --verbose - Optional. Flag. Be chatty.
# Argument: --keep - Optional. Flag. Do not delete artifacts when done, print created values.
#
testPHPBuild() {
  local here testPath manifest appName home

  home=$(__environment buildHome) || return $?
  here=$(__environment pwd) || return $?

  #
  # This MUST be inside the source tree root to run docker in pipelines
  #
  testPath="$(randomString)"
  testPath="${testPath:0:8}"
  appName="sublimeApplication"
  testPath="$here/.test.PHPBuild.$testPath/$appName"
  __environment mkdir -p "$(dirname "$testPath")" || return $?
  __environment cp -r ./test/example/simple-php "$testPath" || return $?
  echo "PWD: $(pwd)"

  buildEnvironmentLoad BUILD_TARGET BUILD_TIMESTAMP

  assertEquals --line "$LINENO" "${BUILD_TARGET}" "app.tar.gz" || return $?

  assertExitCode --line "$LINENO" 0 mkdir -p "$testPath/bin" || return $?
  assertExitCode --line "$LINENO" 0 installInstallBuild "$testPath/bin" "$testPath" || return $?
  assertFileExists --line "$LINENO" "$testPath/bin/install-bin-build.sh" || return $?
  assertFileContains --line "$LINENO" "$testPath/bin/install-bin-build.sh" " .. " || return $?
  here=$(pwd) || _environment pwd || return $?

  consoleInfo "Test build directory is: $testPath" || :

  __environment cd "$testPath" || return $?
  assertFileDoesNotExist --line "$LINENO" "./app.tar.gz" || return $?
  assertDirectoryDoesNotExist --line "$LINENO" "$testPath/bin/build" || return $?

  # Test this version only
  assertExitCode --line "$LINENO" 0 installInstallBuild --local "$testPath/bin" "$testPath" || return $?
  assertFileExists --line "$LINENO" "$testPath/bin/install-bin-build.sh" || return $?
  assertFileContains --line "$LINENO" "$testPath/bin/install-bin-build.sh" " .. " || return $?

  consoleInfo "${BASH_SOURCE{0]}:$LINENO"
  "$testPath/bin/install-bin-build.sh" --mock "$home/bin/build" || return $?
  consoleInfo "${BASH_SOURCE{0]}:$LINENO"
  assertDirectoryExists --line "$LINENO" "$testPath/bin/build" || return $?
  consoleInfo "${BASH_SOURCE{0]}:$LINENO"

  consoleWarning "Building PHP app" || :

  assertEquals --line "$LINENO" "${BUILD_TARGET}" "app.tar.gz" || return $?

  printf "\n"
  # No environment
  bin/build.sh || return $?
  assertFileExists --line "$LINENO" "$testPath/app.tar.gz" || return $?
  rm ./app.tar.gz || return $?

  export APP_THING=secret

  # Add an environment
  printf "\n"
  bin/build.sh APP_THING || return $?
  assertFileExists --line "$LINENO" "$testPath/app.tar.gz" || return $?

  BUILD_TARGET=alternate.tar.gz
  printf "\n"
  bin/build.sh || return $?
  assertFileExists --line "$LINENO" "$testPath/$BUILD_TARGET" || return $?

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

  assertExitCode --stdout-match 'APP_THING="secret"' 1 diff -r ./compare-app ./compare-alternate || return $?

  manifest=$(mktemp) || return $?

  consoleInfo "Extracting app.tar.gz manifest ... "
  tar tf app.tar.gz >"$manifest.complete" || return $?
  grep -v 'vendor/' "$manifest.complete" >"$manifest" || return $?
  assertFileContains --line "$LINENO" "$manifest" .deploy .deploy/APPLICATION_ID .deploy/APPLICATION_TAG simple.application.php src/Application.php .env || return $?
  assertFileDoesNotContain --line "$LINENO" "$manifest" composer.lock composer.json bitbucket-pipelines.yml || return $?
  assertFileContains --line "$LINENO" "$manifest.complete" vendor/zesk vendor/composer || return $?

  consoleSuccess Passed.

  unset APP_THING BUILD_TARGET BUILD_TIMESTAMP
}
