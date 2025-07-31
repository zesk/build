#!/usr/bin/env bash
#
# php-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: package-install
testPHPInstallation() {
  __checkFunctionInstallsAndUninstallsBinary php phpInstall phpUninstall || return $?
}

_testComposerTempDirectory() {
  local handler="_return"

  export BITBUCKET_CLONE_DIR
  # MUST be in BITBUCKET_CLONE_DIR if we're in that CI
  buildEnvironmentLoad BITBUCKET_CLONE_DIR || return $?
  if [ -z "$BITBUCKET_CLONE_DIR" ]; then
    fileTemporaryName "$handler" -d || return $?
  else
    [ -d "$BITBUCKET_CLONE_DIR" ] || __throwEnvironment "$handler" "BITBUCKET_CLONE_DIR=$BITBUCKET_CLONE_DIR is not a directory" || return $?
    fileTemporaryName "$handler" -d --tmpdir="$BITBUCKET_CLONE_DIR" || return $?
  fi
}

#
# Side-effect: installs scripts
# Tag: package-install
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
# Tag: slow
# Tag: php-install simple-php
# Tag: package-install
testPHPBuild() {
  local handler="_return"
  local here testPath manifest appName home

  if __testFunctionWasTested --verbose phpBuild; then
    return 0
  fi

  home=$(__catch "$handler" buildHome) || return $?
  here=$(__catchEnvironment "$handler" pwd) || return $?

  #
  # This MUST be inside the source tree root to run docker in pipelines
  #
  testPath="$(randomString)"
  testPath="${testPath:0:8}"
  appName="sublimeApplication"
  testPath="$here/.test.PHPBuild.$testPath/$appName"
  __catchEnvironment "$handler" mkdir -p "$(dirname "$testPath")" || return $?
  __catchEnvironment "$handler" cp -r ./test/example/simple-php "$testPath" || return $?

  buildEnvironmentLoad BUILD_TARGET BUILD_TIMESTAMP

  assertEquals "${BUILD_TARGET}" "app.tar.gz" || return $?

  assertExitCode 0 mkdir -p "$testPath/bin" || return $?
  assertExitCode 0 installInstallBuild "$testPath/bin" "$testPath" || return $?
  assertFileExists "$testPath/bin/install-bin-build.sh" || return $?
  assertFileContains "$testPath/bin/install-bin-build.sh" " .. " || return $?
  here=$(__catchEnvironment "$handler" pwd) || return $?

  decorate info "Test build directory is: $testPath" || :

  __catchEnvironment "$handler" cd "$testPath" || return $?
  assertFileDoesNotExist "./app.tar.gz" || return $?
  assertDirectoryDoesNotExist "$testPath/bin/build" || return $?

  # Test this version only
  assertExitCode 0 installInstallBuild --local "$testPath/bin" "$testPath" || return $?
  assertFileExists "$testPath/bin/install-bin-build.sh" || return $?
  assertFileContains "$testPath/bin/install-bin-build.sh" " .. " || return $?

  # OLD INSTALLER IS BROKEN
  assertExitCode --dump 0 "$testPath/bin/install-bin-build.sh" --mock "$home/bin/build" || return $?
  assertDirectoryExists "$testPath/bin/build" || return $?

  decorate warning "Building PHP app" || :

  assertEquals "${BUILD_TARGET}" "app.tar.gz" || return $?

  printf "\n"
  # No environment

  bin/build.sh || return $?
  assertFileExists "$testPath/app.tar.gz" || return $?
  __catchEnvironment "$handler" rm ./app.tar.gz || return $?

  export APP_THING=secret

  # Add an environment
  printf "\n"
  __catchEnvironment "$handler" bin/build.sh APP_THING || return $?
  assertFileExists "$testPath/app.tar.gz" || return $?

  BUILD_TARGET=alternate.tar.gz
  printf "\n"
  __catchEnvironment "$handler" bin/build.sh || return $?
  assertFileExists "$testPath/$BUILD_TARGET" || return $?

  __catchEnvironment "$handler" mkdir ./compare-app || return $?
  __catchEnvironment "$handler" mkdir ./compare-alternate || return $?
  __catchEnvironment "$handler" cd ./compare-app || return $?

  decorate info "Extracting app.tar.gz ... "
  __catchEnvironment "$handler" tar xf ../app.tar.gz || return $?
  # Vendor has random numbers in the classnames
  __catchEnvironment "$handler" rm -rf ./vendor || return $?
  __catchEnvironment "$handler" cd .. || return $?

  __catchEnvironment "$handler" cd ./compare-alternate || return $?

  decorate info "Extracting alternate.tar.gz ... "
  __catchEnvironment "$handler" tar xf ../alternate.tar.gz || return $?
  __catchEnvironment "$handler" rm -rf ./vendor || return $?
  __catchEnvironment "$handler" cd .. || return $?

  assertExitCode --stdout-match 'APP_THING="secret"' 1 diff -r ./compare-app ./compare-alternate || return $?

  manifest=$(fileTemporaryName "$handler") || return $?

  decorate info "Extracting app.tar.gz manifest ... "
  __catchEnvironment "$handler" tar tf app.tar.gz >"$manifest.complete" || return $?
  __catchEnvironment "$handler" grep -v 'vendor/' "$manifest.complete" >"$manifest" || return $?
  assertFileContains "$manifest" .deploy .deploy/APPLICATION_ID .deploy/APPLICATION_TAG simple.application.php src/Application.php .env || return $?
  assertFileDoesNotContain "$manifest" composer.lock composer.json bitbucket-pipelines.yml || return $?
  assertFileContains "$manifest.complete" vendor/zesk vendor/composer || return $?

  decorate success Passed.

  unset APP_THING BUILD_TARGET BUILD_TIMESTAMP
}

testPHPComposerSetVersion() {
  local home testHome usage="_return"

  home=$(__catch "$usage" buildHome) || return $?

  testHome=$(fileTemporaryName "$usage" -d) || return $?

  __catchEnvironment "$usage" cp -R "$home" "$testHome/testDir" || return $?
  __mockValue BUILD_HOME

  export BUILD_HOME
  BUILD_HOME="$testHome/testDir"

  local testVersionFile="$BUILD_HOME/composer.json"
  assertNotExitCode --stderr-match "composer.json" 0 phpComposerSetVersion || return $?
  printf "%s\n" "{}" >"$testVersionFile" || return $?

  assertExitCode 0 phpComposerSetVersion --version "1.0" || return $?
  assertFileContains "$testVersionFile" "1.0" || return $?
  assertExitCode 0 phpComposerSetVersion --version "foobar" || return $?
  assertFileContains "$testVersionFile" "foobar" || return $?
  assertExitCode 0 phpComposerSetVersion || return $?

  version=$(hookVersionCurrent) || return $?
  assertFileDoesNotContain "$testVersionFile" "$version" || return $?
  noVeeVersion=$(versionNoVee "$version") || return $?
  assertFileContains --line "$LINENO" "$testVersionFile" "$noVeeVersion" || return $?

  __mockValueStop BUILD_HOME

  __catchEnvironment "$usage" rm -rf "$testHome" || return $?
}
