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
  assertExitCode 0 runHook version-live
}

tests+=(testNewRelease)
testNewRelease() {
  assertExitCode 0 newRelease --non-interactive
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
    tail -n 20 "$testBinary" | prefixLines "$(consoleCode)"
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
  tempDir="./random.$$/"
  mkdir -p "$tempDir" || :
  cp ./bin/build/map.sh "./random.$$/"
  export DUDE=ax
  export WILD=m
  assertEquals "$(echo "{WILD}{DUDE}i{WILD}u{WILD}" | ./random.$$/map.sh)" "maximum"
  rm -rf "$tempDir"
}

#
# Side-effect: installs scripts
#
tests+=(testScriptInstallations)
testScriptInstallations() {
  if ! which docker-compose >/dev/null; then
    __doesScriptInstall docker-compose dockerComposeInstall || return $?
  fi

  if ! which php >/dev/null; then
    __doesScriptInstall php phpInstall || return $?
  fi
  __doesScriptInstall python pythonInstall || return $?
  __doesScriptInstall mariadb mariadbInstall || return $?
  # requires docker
  d=$(mktemp -d)
  cp ./test/example/simple-php/composer.json ./test/example/simple-php/composer.lock "$d/"
  phpComposer "$d"
  if [ ! -d "$d/vendor" ] || [ ! -f "$d/composer.lock" ]; then
    consoleError "composer failed"
    return "$errorEnvironment"
  fi

  if ! which git >/dev/null; then
    __doesScriptInstall git gitInstall || return $?
  fi
  if ! which npm >/dev/null; then
    # npm 18 installed in this image
    __doesScriptInstall npm npmInstall || return $?
  fi
  __doesScriptInstall prettier prettierInstall || return $?
  __doesScriptInstall terraform terraformInstall || return $?
}

# tests=(testAdditionalBins "${tests[@]}")
tests+=(testAdditionalBins)
testAdditionalBins() {
  for binTest in ./test/bin/*.sh; do
    testHeading "$(cleanTestName "$(basename "$binTest")")"
    if ! "$binTest" "$(pwd)"; then
      testFailed "$binTest" "$(pwd)"
      return $errorEnvironment
    fi
  done
}
