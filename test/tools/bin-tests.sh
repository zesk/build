#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

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
  assertFileExists "$testBinary" || return $?
  marker=$(randomString)
  echo " # changed $marker" >>"$testBinary"
  if ! grep -q "$marker" "$testBinary"; then
    decorate error "binary $testBinary does not contain marker?"
    return 1
  fi
  assertFileContains --line "$LINENO" "$testBinary" '../../..' || return $?

  __environment cp "$testBinary" "$testBinary.backup" || return $?

  assertDirectoryDoesNotExist --line "$LINENO" "$topDir/bin/build" || return $?

  assertExitCode --stdout-match "zesk/build" --stdout-match "Installed" 0 "$testBinary" --mock "$BUILD_HOME/bin/build" || return $?

  if [ ! -d "$topDir/bin/build" ]; then
    find "$topDir" -type f
    find "$topDir" -type d
    decorate error "binary $testBinary failed to do the job ($topDir/bin/build)"
    return 1
  fi
  if grep -q "$marker" "$testBinary"; then
    decorate error "binary $testBinary did not update itself as it should have ($marker found)"
    dumpPipe --tail "$testBinary last 20" <"$testBinary"
    return 1
  fi
  # Do not use updated binary as behavior is unpredictable (this is the last version)
  __environment mv -f "$testBinary.backup" "$testBinary" || return $?

  assertExitCode --stdout-match "already installed" 0 "$testBinary" || return $?

  decorate success "install-bin-build.sh update was tested successfully"
  rm -rf "$topDir"
}

testMapBin() {
  local expected actual

  __testSection testMap

  actual="$(echo "{FOO}{BAR}{foo}{bar}{BAR}" | FOO=test BAR=goob bin/build/map.sh)"

  expected="testgoob{foo}{bar}goob"

  assertEquals "$expected" "$actual" || return $?
}

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

# Tag: slow
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
