#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

tests+=(testAdditionalBins)
tests+=(testGitInstallation)
#tests+=(testInstallInstallBuild)
tests+=(testInstallTerraform)
tests+=(testMapBin)
tests+=(testMapPortability)
tests+=(testMariaDBInstallation)
tests+=(testNewRelease)
tests+=(testNodeInstallations)
tests+=(testPHPComposerInstallation)
tests+=(testPHPInstallation)
tests+=(testPythonInstallation)
tests+=(testVersionLive)

testVersionLive() {
  assertExitCode --line "$LINENO" 0 runHook version-live || return $?
}

testNewRelease() {
  assertExitCode --line "$LINENO" 0 newRelease --non-interactive || return $?
}

__testInstallInstallBuild() {
  local topDir targetDir marker testBinary
  export BUILD_HOME

  __environment buildEnvironmentLoad BUILD_HOME || return $?
  assertDirectoryExists "$BUILD_HOME" || return $?

  topDir="$(pwd)/test.$$"
  targetDir="$topDir/bin/deeper/deepest"
  __environment mkdir -p "$targetDir" || return $?
  assertDirectoryExists --line "$LINENO" "$targetDir" || return $?
  testBinary="$targetDir/install-bin-build.sh"
  assertExitCode --dump --line "$LINENO" 0 installInstallBuild --local "$targetDir" "$topDir" || return $?
  assertFileExists --line "$LINENO" "$testBinary" || return $?
  marker=$(randomString)
  echo " # changed $marker" >>"$testBinary"
  if ! grep -q "$marker" "$testBinary"; then
    consoleError "binary $testBinary does not contain marker?"
    return 1
  fi
  assertFileContains --line "$LINENO" "$testBinary" '../../..' || return $?

  __environment cp "$testBinary" "$testBinary.backup" || return $?

  assertDirectoryDoesNotExist --line "$LINENO" "$topDir/bin/build" || return $?

  assertExitCode --line "$LINENO" --stdout-match "zesk/build" --stdout-match "Installed" 0 "$testBinary" --mock "$BUILD_HOME/bin/build" || return $?

  if [ ! -d "$topDir/bin/build" ]; then
    find "$topDir" -type f
    find "$topDir" -type d
    consoleError "binary $testBinary failed to do the job ($topDir/bin/build)"
    return 1
  fi
  if grep -q "$marker" "$testBinary"; then
    consoleError "binary $testBinary did not update itself as it should have ($marker found)"
    dumpPipe --tail "$testBinary last 20" <"$testBinary"
    return 1
  fi
  # Do not use updated binary as behavior is unpredictable (this is the last version)
  __environment mv -f "$testBinary.backup" "$testBinary" || return $?

  assertExitCode --line "$LINENO" --stdout-match "already installed" 0 "$testBinary" || return $?

  consoleSuccess "install-bin-build.sh update was tested successfully"
  rm -rf "$topDir"
}

tests+=(testMapBin)
testMapBin() {
  local expected actual

  __testSection testMap

  actual="$(echo "{FOO}{BAR}{foo}{bar}{BAR}" | FOO=test BAR=goob bin/build/map.sh)"

  expected="testgoob{foo}{bar}goob"

  assertEquals --line "$LINENO" "$expected" "$actual" || return $?
}

testMapPortability() {
  local tempDir

  tempDir="./random.$$/"
  mkdir -p "$tempDir" || :
  cp ./bin/build/map.sh "./random.$$/"
  export DUDE=ax
  export WILD=m
  assertEquals --line "$LINENO" "$(echo "{WILD}{DUDE}i{WILD}u{WILD}" | ./random.$$/map.sh)" "maximum" || return $?
  rm -rf "$tempDir"
  unset DUDE WILD
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
tests+=(testPHPComposerInstallation)
testPHPComposerInstallation() {
  local d oldDir

  oldDir="${BITBUCKET_CLONE_DIR-NONE}"

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

tests+=(testGitInstallation)
testGitInstallation() {
  __doesScriptInstallUninstall git gitInstall gitUninstall || return $?
}

tests+=(testPythonInstallation)
testPythonInstallation() {
  __doesScriptInstallUninstall python pythonInstall pythonUninstall || return $?
}

tests+=(testMariaDBInstallation)
testMariaDBInstallation() {
  __doesScriptInstallUninstall mariadb mariadbInstall mariadbUninstall || return $?
}

tests+=(testPHPInstallation)
testPHPInstallation() {
  __doesScriptInstallUninstall php phpInstall phpUninstall || return $?
}

#
# Side-effect: installs and uninstalls scripts
#
tests+=(testNodeInstallations)
testNodeInstallations() {
  # npm 18 installed in this image
  if ! whichExists npm; then
    # Part of core install in some systems, so no uninstall
    __doesScriptInstall npm npmInstall || return $?
  fi
  if ! whichExists docker-compose; then
    # Part of core install in some systems, so no uninstall
    __doesScriptInstall docker-compose dockerComposeInstall || return $?
  fi
  __doesScriptInstallUninstall prettier prettierInstall prettierUninstall || return $?
}

tests+=(testInstallTerraform)
testInstallTerraform() {
  __doesScriptInstallUninstall terraform terraformInstall terraformUninstall || return $?
}

tests+=(testAdditionalBins)
testAdditionalBins() {
  local binTest
  local aa

  for binTest in ./test/bin/*.sh; do
    __testSection "$(basename "$binTest")"
    aa=()
    if grep -q 'stderr-ok' "$binTest" >/dev/null; then
      aa=(--stderr-ok)
    fi
    assertExitCode "${aa[@]+"${aa[@]}"}" --line "$LINENO" 0 "$binTest" "$(pwd)" || return $?
  done
}

__doesScriptInstall() {
  local binary="${1-}"

  __testSection "INSTALL $binary"
  shift
  ! whichExists "$binary" || _environment "binary" "$(consoleCode "$binary")" "is already installed" || return $?
  __environment "$@" || return $?
  whichExists "$binary" || _environment "binary" "$(consoleCode "$binary")" "was not installed by" "$@" || return $?
}

__doesScriptInstallUninstall() {
  local binary=$1 script=$2 undoScript="$3"
  local uninstalledAlready

  uninstalledAlready=false
  if whichExists "$binary"; then
    __testSection "UNINSTALL $binary (already)" || :
    __environment "$undoScript" || return $?
    uninstalledAlready=true
  else
    consoleInfo "binary $binary is not installed - installing"
  fi
  __doesScriptInstall "$binary" "$script" || return $?
  if ! $uninstalledAlready; then
    __testSection "UNINSTALL $binary (just installed)" || :
    __environment "$undoScript" || return $?
    ! whichExists "$binary" || _environment "binary" "$(consoleCode "$binary")" "exists after uninstalling" || return $?
  fi
}
