#!/usr/bin/env bash
#
# daemontools-tests.sh
#
# daemontools tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

declare -a tests

tests+=(testInstallInstallBuildSelf)
tests+=(testInstallBinBuild)

testInstallInstallBuildSelf() {
  local tempD
  export BUILD_COMPANY

  tempD=$(mktemp -d) || _environment mktemp || return $?

  __environment buildEnvironmentLoad BUILD_COMPANY || return $?
  __environment mkdir -p "$tempD/a/b/c/d/e/f" || return $?

  assertFileDoesNotExist "$tempD/a/b/c/d/e/f/install-bin-build.sh" || return $?
  assertExitCode --stdout-match '../../../../../..' 0 installInstallBuild "$tempD/a/b/c/d/e/f" "$tempD" || return $?
  assertFileExists "$tempD/a/b/c/d/e/f/install-bin-build.sh" || return $?
  assertFileContains "$tempD/a/b/c/d/e/f/install-bin-build.sh" "${BUILD_COMPANY}" || return $?

  rm -rf "$tempD" || :

  unset BUILD_COMPANY
}


#
# fn: {base}
# Usage: {fn} buildHome
#
testInstallBinBuild() {
  local usage="_${FUNCNAME[0]}"
  local testDir testBinBuild section buildHome matches

  export BUILD_HOME
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_HOME || return $?
  buildHome="${BUILD_HOME-}"
  assertDirectoryExists "$BUILD_HOME" || return $?
  section=0
  testDir=$(mktemp -d)
  testBinBuild="$testDir/bin/pipeline/install-bin-build.sh"
  __usageEnvironment "$usage" cd "$testDir" || return $?

  __usageEnvironment "$usage" mkdir -p bin/pipeline || return $?
  __usageEnvironment "$usage" cp "$buildHome/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  __usageEnvironment "$usage" echo '# this make the file different' >>"$testBinBuild" || return $?

  # --------------------------------------------------------------------------------
  #
  clearLine
  boxedHeading "No .gitignore, was updated, same name"
  #
  section=$((section + 1))
  bigText "Section #$section"

  #  ▞▀▖      ▐  ▗           ▗▌
  #  ▚▄ ▞▀▖▞▀▖▜▀ ▄ ▞▀▖▛▀▖ ▟▟▖ ▌
  #  ▖ ▌▛▀ ▌ ▖▐ ▖▐ ▌ ▌▌ ▌ ▟▟▖ ▌
  #  ▝▀ ▝▀▘▝▀  ▀ ▀▘▝▀ ▘ ▘ ▝▝ ▝▀

  assertDirectoryDoesNotExist --line "$LINENO" "$testDir/bin/build" || return $?
  export BUILD_DIFF=1

  assertFileContains --line "$LINENO" "$testBinBuild" "make the file different" || return $?

  matches=(
    --stdout-match "install-bin-build.sh"
    --stdout-no-match "rubs.sh"
    --stdout-no-match "already installed"
    --stdout-no-match "does not ignore"
    --stdout-match "Installed"
  )

  assertExitCode --line "$LINENO" "${matches[@]}" 0 "$testDir/bin/pipeline/install-bin-build.sh" --mock "$buildHome/bin/build" || return $?
  assertFileDoesNotContain --line "$LINENO" "$testBinBuild" "make the file different" || return $?
  assertFileContains --line "$LINENO" "$testBinBuild" "installBinBuild ../.. " || return $?

  rm -rf bin/build || return $?

  consoleSuccess Success

  # --------------------------------------------------------------------------------
  #
  clearLine
  boxedHeading "Has gitignore (missing), missing, different name"
  section=$((section + 1))
  bigText "Section #$section"

  #  ▞▀▖      ▐  ▗           ▞▀▖
  #  ▚▄ ▞▀▖▞▀▖▜▀ ▄ ▞▀▖▛▀▖ ▟▟▖ ▗▘
  #  ▖ ▌▛▀ ▌ ▖▐ ▖▐ ▌ ▌▌ ▌ ▟▟▖▗▘
  #  ▝▀ ▝▀▘▝▀  ▀ ▀▘▝▀ ▘ ▘ ▝▝ ▀▀▘

  assertDirectoryDoesNotExist --line "$LINENO" bin/build || return $?

  touch .gitignore || return $?
  assertExitCode 0 mv bin/pipeline/install-bin-build.sh bin/pipeline/we-like-head-rubs.sh || return $?

  # Test
  matches=(
    --stdout-match "we-like-head-rubs.sh"
    --stdout-no-match "install-bin-build.sh"

    --stdout-match "Installed"
    --stdout-no-match "already installed"

    --stdout-match "does not ignore"
    --stdout-match ".gitignore"
  )
  clearLine

  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" || return $?

  clearLine
  boxedHeading "Has gitignore (missing), bin/build exists, different name"
  section=$((section + 1))
  bigText "Section #$section"

  # Change
  : Already installed

  matches=(
    --stdout-no-match "we-like-head-rubs.sh"
    --stdout-no-match "install-bin-build.sh"

    --stdout-no-match "Installed"
    --stdout-match "already installed"

    --stdout-match "does not ignore"
    --stdout-match ".gitignore"
  )
  assertExitCode --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" || return $?
  assertDirectoryExists --line "$LINENO" bin/build || return $?

  boxedHeading "Has gitignore (correct), bin/build exists, different name"
  section=$((section + 1))
  bigText "Section #$section"

  # Change
  echo "/bin/build/" >>.gitignore

  # .gitignore errors reversed
  matches=(
    --stdout-no-match "we-like-head-rubs.sh"
    --stdout-no-match "install-bin-build.sh"

    --stdout-no-match "Installed"
    --stdout-match "already installed"

    --stdout-no-match "does not ignore"
    --stdout-no-match ".gitignore"
  )
  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" || return $?
  # Check

  rm -rf "$testDir" || :

  consoleSuccess Success
}
_testInstallBinBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
