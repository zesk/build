#!/bin/bash
#
# setup-git-test.sh
#
# install-bin-build.sh tests
#
# Note that this tests the LIVE version of build-setup.sh so it's a version behind
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 13
# Usage: __tools command ...
# Load zesk build and run command
__tools() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/tools.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
}

#
# fn: {base}
# Usage: {fn} buildHome
#
setupGitTest() {
  local usage="_${FUNCNAME[0]}"
  local testDir testBinBuild section logFile buildHome

  export BUILD_HOME
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_HOME || return $?
  buildHome=$BUILD_HOME
  section=0
  testDir=$(mktemp -d)
  testBinBuild="$testDir/bin/pipeline/install-bin-build.sh"
  __usageEnvironment "$usage" cd "$testDir" || return $?

  __usageEnvironment "$usage" mkdir -p bin/pipeline || return $?
  __usageEnvironment "$usage" cp "$buildHome/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  __usageEnvironment "$usage" echo '# this make the file different' >>"$testBinBuild" || return $?

  # --------------------------------------------------------------------------------
  #
  boxedHeading "No .gitignore, was updated, same name"
  #
  section=$((section + 1))
  bigText "Section #$section"
  logFile=$section.log

  assertDirectoryDoesNotExist --line "$LINENO" "$testDir/bin/build" || return $?
  export BUILD_DIFF=1

  assertFileContains --line "$LINENO" "$testBinBuild" "make the file different" || return $?

  if ! __usageEnvironment "$usage" "$testDir/bin/pipeline/install-bin-build.sh" --mock "$buildHome/bin/build" >"$logFile" 2>&1; then
    buildFailed "$logFile" || return $?
  fi
  sleep 1 || :

  assertDirectoryExists --line "$LINENO" bin/build || return $?
  assertFileContains --line "$LINENO" "$logFile" install-bin-build.sh || return $?
  assertFileContains --line "$LINENO" "$logFile" "Installed" || return $?
  # CHECK THESE?
  assertFileDoesNotContain --line "$LINENO" "$logFile" "already installed" "does not ignore" || return $?
  assertFileDoesNotContain --line "$LINENO" "$testBinBuild" "make the file different" || return $?

  rm -rf bin/build || return $?

  consoleSuccess Success

  # --------------------------------------------------------------------------------
  #
  boxedHeading "Has gitignore (missing), missing, different name"
  section=$((section + 1))
  bigText "Section #$section"
  logFile=$section.log

  assertDirectoryDoesNotExist --line "$LINENO" bin/build || return $?

  touch .gitignore || return $?
  mv bin/pipeline/install-bin-build.sh bin/pipeline/we-like-head-rubs.sh || return $?

  # Test
  if ! __usageEnvironment "$usage" bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1; then
    buildFailed "$logFile" || return $?
  fi

  # .gitignore errors
  assertFileContains --line "$LINENO" "$logFile" "does not ignore" || return $?
  assertFileContains --line "$LINENO" "$logFile" ".gitignore" || return $?

  # install
  assertDirectoryExists --line "$LINENO" bin/build || return $?
  assertFileContains --line "$LINENO" "$logFile" we-like-head-rubs.sh || return $?
  assertFileDoesNotContain --line "$LINENO" "$logFile" "install-bin-build.sh" || return $?

  # install mode
  assertFileDoesNotContain --line "$LINENO" "$logFile" "already installed" || return $?
  assertFileContains --line "$LINENO" "$logFile" "Installed" || return $?

  boxedHeading "Has gitignore (missing), bin/build exists, different name"
  section=$((section + 1))
  bigText "Section #$section"
  logFile=$section.log

  # Change
  : Already installed

  # Test
  if ! __usageEnvironment "$usage" bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1; then
    buildFailed "$logFile" || return $?
  fi

  # .gitignore errors
  assertFileContains --line "$LINENO" "$logFile" "does not ignore" || return $?
  assertFileContains --line "$LINENO" "$logFile" ".gitignore" || return $?

  # install
  assertDirectoryExists --line "$LINENO" bin/build || return $?
  assertFileContains --line "$LINENO" "$logFile" we-like-head-rubs.sh || return $?
  assertFileDoesNotContain --line "$LINENO" "$logFile" "install-bin-build.sh" || return $?

  # install mode reversed
  assertFileContains --line "$LINENO" "$logFile" "already installed" || return $?
  assertFileDoesNotContain --line "$LINENO" "$logFile" "Installed" || return $?

  boxedHeading "Has gitignore (correct), bin/build exists, different name"
  section=$((section + 1))
  bigText "Section #$section"
  logFile=$section.log

  # Change
  echo "/bin/build/" >>.gitignore

  # Test
  if ! __usageEnvironment "$usage" bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1; then
    buildFailed "$logFile" || return $?
  fi

  # Check

  # .gitignore errors reversed
  assertFileDoesNotContain --line "$LINENO" "$logFile" "does not ignore" || return $?
  assertFileDoesNotContain --line "$LINENO" "$logFile" ".gitignore" || return $?

  # install
  assertDirectoryExists --line "$LINENO" bin/build || return $?
  assertFileContains --line "$LINENO" "$logFile" we-like-head-rubs.sh || return $?
  assertFileDoesNotContain --line "$LINENO" "$logFile" "install-bin-build.sh" || return $?

  # install mode reversed
  assertFileContains --line "$LINENO" "$logFile" "already installed" || return $?
  assertFileDoesNotContain --line "$LINENO" "$logFile" "Installed" || return $?

  rm -rf "$testDir" || :

  consoleSuccess Success
}
_setupGitTest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. setupGitTest "$@"
