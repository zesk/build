#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
errorEnvironment=1

declare -a tests

tests+=(testVersionLive)
testVersionLive() {
  assertExitCode 0 runHook version-live || return $?
}

tests+=(testNewRelease)
testNewRelease() {
  assertExitCode 0 newRelease --non-interactive || return $?
}

tests+=(testBuildSetup)
testBuildSetup() {
  local topDir targetDir marker testBinary testOutput

  testSection install-bin-build.sh
  topDir="$(pwd)/test.$$"
  targetDir="$topDir/bin/deeper/deepest"
  mkdir -p "$targetDir"
  testBinary="$targetDir/install-bin-build.sh"
  cp bin/build/install-bin-build.sh "$testBinary"
  sed -i -e 's/^relTop=.*/relTop=..\/..\/../g' "$testBinary"
  chmod +x "$testBinary"
  marker=$(randomString)
  echo " # changed $marker" >>"$testBinary"

  if ! grep -q "$marker" "$testBinary"; then
    consoleError "binary $testBinary does not contain marker?"
    return "$errorEnvironment"
  fi

  testOutput=$(mktemp)
  if ! $testBinary >"$testOutput"; then
    consoleError "Binary $testBinary failed"
    return "$errorEnvironment"
  fi

  if ! grep -q "was updated" "$testOutput"; then
    consoleError "Missing was updated from $testBinary"
    buildFailed "$testOutput"
  fi

  if [ ! -d "test.$$/bin/build" ]; then
    consoleError "binary $testBinary failed to do the job"
    return "$errorEnvironment"
  fi
  if grep -q "$marker" "$testBinary"; then
    consoleError "binary $testBinary did not update itself as it should have ($marker found)"
    tail -n 20 "$testBinary" | wrapLines "$(consoleCode)" "$(consoleReset)"
    return "$errorEnvironment"
  fi

  if ! $testBinary >"$testOutput"; then
    consoleError "Binary $testBinary failed 2nd round - ok as live script is dead"
    return "$errorEnvironment"
  fi

  if ! grep -q "up to date" "$testOutput"; then
    consoleError "Missing up to date from $testBinary"
    buildFailed "$testOutput"
  fi

  consoleSuccess "install-bin-build.sh update was tested successfully"
  rm -rf "$topDir"
}

tests+=(testMapBin)
testMapBin() {
  local result expected

  testSection testMap
  export FOO=test
  export BAR=goob

  result="$(echo "{FOO}{BAR}{foo}{bar}{BAR}" | bin/build/map.sh)"

  expected="testgoob{foo}{bar}goob"
  if [ "$result" != "$expected" ]; then
    consoleError "map.sh failed: $result != $expected"
    exit "$errorEnvironment"
  fi
  consoleSuccess testMapBin OK

  unset FOO BAR
}

#
# testShellScripts moved into tools/
#

__doesScriptInstall() {
  local binary=$1 script=$2
  testSection "$binary"
  if which "$binary" >/dev/null; then
    consoleError "binary $binary is already installed?"
    return "$errorEnvironment"
  fi
  $script
  if ! which "$binary" >/dev/null; then
    consoleError "binary $binary was not installed by $script"
    return "$errorEnvironment"
  fi
}

tests+=(testMapPortability)
testMapPortability() {
  local tempDir

  tempDir="./random.$$/"
  mkdir -p "$tempDir" || :
  cp ./bin/build/map.sh "./random.$$/"
  export DUDE=ax
  export WILD=m
  assertEquals "$(echo "{WILD}{DUDE}i{WILD}u{WILD}" | ./random.$$/map.sh)" "maximum" || return $?
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
tests+=(testScriptInstallations)
testScriptInstallations() {
  local d oldDir

  oldDir="${BITBUCKET_CLONE_DIR-NONE}"
  if ! which docker-compose >/dev/null; then
    __doesScriptInstall docker-compose dockerComposeInstall || return $?
  fi

  if ! which php >/dev/null; then
    __doesScriptInstall php phpInstall || return $?
  fi
  __doesScriptInstall python pythonInstall || return $?
  __doesScriptInstall mariadb mariadbInstall || return $?
  # requires docker
  # MUST be in BITBUCKET_CLONE_DIR if we're in that CI

  d=$(_testComposerTempDirectory) || _environment "_testComposerTempDirectory" | return $?
  cp ./test/example/simple-php/composer.json ./test/example/simple-php/composer.lock "$d/"
  __environment phpComposer "$d" || return $?
  [ -d "$d/vendor" ] && [ -f "$d/composer.lock" ] || _environment "composer failed" || return $?

  if ! which git >/dev/null; then
    __doesScriptInstall git gitInstall || return $?
  fi
  if ! which npm >/dev/null; then
    # npm 18 installed in this image
    __doesScriptInstall npm npmInstall || return $?
  fi
  __doesScriptInstall prettier prettierInstall || return $?
  __doesScriptInstall terraform terraformInstall || return $?

  export BITBUCKET_CLONE_DIR
  BITBUCKET_CLONE_DIR="$oldDir"
  [ "$oldDir" = "NONE" ] && unset BITBUCKET_CLONE_DIR
}

# tests=(testAdditionalBins "${tests[@]}")
tests+=(testAdditionalBins)
testAdditionalBins() {
  local binTest

  for binTest in ./test/bin/*.sh; do
    testHeading "$(cleanTestName "$(basename "$binTest")")"
    if ! "$binTest" "$(pwd)"; then
      _environment "$(testFailed "$binTest" "$(pwd)")" || return $?
    fi
  done
}
