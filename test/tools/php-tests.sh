#!/usr/bin/env bash
#
# php-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testPHPInstallation() {
  __checkFunctionInstallsAndUninstallsBinary php phpInstall phpUninstall || return $?
}

_testComposerTempDirectory() {
  export BITBUCKET_CLONE_DIR
  # MUST be in BITBUCKET_CLONE_DIR if we're in that CI
  buildEnvironmentLoad BITBUCKET_CLONE_DIR || return $?
  if [ -z "$BITBUCKET_CLONE_DIR" ]; then
    mktemp -d
  else
    [ -d "$BITBUCKET_CLONE_DIR" ] || _environment "BITBUCKET_CLONE_DIR=$BITBUCKET_CLONE_DIR is not a directory" || return $?
    mktemp -d --tmpdir="$BITBUCKET_CLONE_DIR"
  fi
}

#
# Side-effect: installs scripts
#
testPHPComposerInstallation() {
  local d oldDir

  oldDir="${BITBUCKET_CLONE_DIR-NONE}"

  if __testFunctionWasTested --verbose phpComposer; then
    return 0
  fi
  # requires docker
  # MUST be in BITBUCKET_CLONE_DIR if we're in that CI

  d=$(__environment _testComposerTempDirectory) || return $?
  __environment cp ./test/example/simple-php/composer.json ./test/example/simple-php/composer.lock "$d/" || return $?
  __environment phpComposer "$d" || return $?
  [ -d "$d/vendor" ] && [ -f "$d/composer.lock" ] || _environment "composer failed" || return $?

  export BITBUCKET_CLONE_DIR
  BITBUCKET_CLONE_DIR="$oldDir"
  [ "$oldDir" != "NONE" ] || unset BITBUCKET_CLONE_DIR
}

#
# Usage: {fn} [ --show ] [ --verbose ] [ --keep ]
# Argument: --show - Optional. Flag. Print the displayed test crontab file to stdout.
# Argument: --verbose - Optional. Flag. Be chatty.
# Argument: --keep - Optional. Flag. Do not delete artifacts when done, print created values.
#
testPHPBuild() {
  local here testPath manifest appName home

  if __testFunctionWasTested --verbose phpBuild; then
    return 0
  fi

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

  buildEnvironmentLoad BUILD_TARGET BUILD_TIMESTAMP

  assertEquals --line "$LINENO" "${BUILD_TARGET}" "app.tar.gz" || return $?

  assertExitCode --line "$LINENO" 0 mkdir -p "$testPath/bin" || return $?
  assertExitCode --line "$LINENO" 0 installInstallBuild "$testPath/bin" "$testPath" || return $?
  assertFileExists --line "$LINENO" "$testPath/bin/install-bin-build.sh" || return $?
  assertFileContains --line "$LINENO" "$testPath/bin/install-bin-build.sh" " .. " || return $?
  here=$(pwd) || _environment pwd || return $?

  decorate info "Test build directory is: $testPath" || :

  __environment cd "$testPath" || return $?
  assertFileDoesNotExist --line "$LINENO" "./app.tar.gz" || return $?
  assertDirectoryDoesNotExist --line "$LINENO" "$testPath/bin/build" || return $?

  # Test this version only
  assertExitCode --line "$LINENO" 0 installInstallBuild --local "$testPath/bin" "$testPath" || return $?
  assertFileExists --line "$LINENO" "$testPath/bin/install-bin-build.sh" || return $?
  assertFileContains --line "$LINENO" "$testPath/bin/install-bin-build.sh" " .. " || return $?

  # OLD INSTALLER IS BROKEN
  assertExitCode --dump 0 "$testPath/bin/install-bin-build.sh" --mock "$home/bin/build" || return $?
  assertDirectoryExists --line "$LINENO" "$testPath/bin/build" || return $?

  decorate warning "Building PHP app" || :

  assertEquals --line "$LINENO" "${BUILD_TARGET}" "app.tar.gz" || return $?

  printf "\n"
  # No environment

  bin/build.sh || return $?
  assertFileExists --line "$LINENO" "$testPath/app.tar.gz" || return $?
  rm ./app.tar.gz || return $?

  export APP_THING=secret

  # Add an environment
  printf "\n"
  __environment bin/build.sh APP_THING || return $?
  assertFileExists --line "$LINENO" "$testPath/app.tar.gz" || return $?

  BUILD_TARGET=alternate.tar.gz
  printf "\n"
  __environment bin/build.sh || return $?
  assertFileExists --line "$LINENO" "$testPath/$BUILD_TARGET" || return $?

  mkdir ./compare-app || return $?
  mkdir ./compare-alternate || return $?
  cd ./compare-app || return $?

  decorate info "Extracting app.tar.gz ... "
  tar xf ../app.tar.gz || return $?
  # Vendor has random numbers in the classnames
  rm -rf ./vendor || return $?
  cd .. || return $?

  cd ./compare-alternate || return $?

  decorate info "Extracting alternate.tar.gz ... "
  tar xf ../alternate.tar.gz || return $?
  rm -rf ./vendor || return $?
  cd .. || return $?

  assertExitCode --stdout-match 'APP_THING="secret"' 1 diff -r ./compare-app ./compare-alternate || return $?

  manifest=$(mktemp) || return $?

  decorate info "Extracting app.tar.gz manifest ... "
  tar tf app.tar.gz >"$manifest.complete" || return $?
  grep -v 'vendor/' "$manifest.complete" >"$manifest" || return $?
  assertFileContains --line "$LINENO" "$manifest" .deploy .deploy/APPLICATION_ID .deploy/APPLICATION_TAG simple.application.php src/Application.php .env || return $?
  assertFileDoesNotContain --line "$LINENO" "$manifest" composer.lock composer.json bitbucket-pipelines.yml || return $?
  assertFileContains --line "$LINENO" "$manifest.complete" vendor/zesk vendor/composer || return $?

  decorate success Passed.

  unset APP_THING BUILD_TARGET BUILD_TIMESTAMP
}
