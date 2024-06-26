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

# IDENTICAL __tools 12
# Load tools.sh and run command
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

# IDENTICAL _return 8
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}"
  shift
  printf "%s ❌ (%d)\n" "${*-§}" "$code" 1>&2
  return "$code"
}

#
# fn: {base}
# Usage: {fn} buildHome
#
setupGitTest() {
  local usage="_${FUNCNAME[0]}"
  local testDir testBinBuild title section logFile buildHome

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
  title="No .gitignore, was updated, same name"
  #
  section=$((section + 1))
  labeledBigText "$title" "Section #$section"
  logFile=$section.log

  assertDirectoryDoesNotExist bin/build || return $?
  export BUILD_DIFF=1

  assertFileContains "$testBinBuild" "make the file different" || return $?

  if ! __usageEnvironment "$usage" bin/pipeline/install-bin-build.sh --mock "$buildHome/bin/build" >"$logFile" 2>&1; then
    buildFailed "$logFile" || return $?
  fi
  sleep 1 || :

  assertDirectoryExists bin/build || return $?
  assertFileContains "$logFile" install-bin-build.sh || return $?
  assertFileContains "$logFile" "was updated" || return $?
  assertFileDoesNotContain "$logFile" "is up to date" "does not ignore" || return $?
  assertFileDoesNotContain "$testBinBuild" "make the file different" || return $?

  rm -rf bin/build || return $?
  set +x

  consoleSuccess Success

  # --------------------------------------------------------------------------------
  #
  title="Has gitignore (missing), up to date, different name"
  #
  section=$((section + 1))
  labeledBigText "$title" "Section #$section"
  logFile=$section.log

  assertDirectoryDoesNotExist bin/build || return $?

  touch .gitignore || return $?
  mv bin/pipeline/install-bin-build.sh bin/pipeline/we-like-head-rubs.sh || return $?

  if ! __usageEnvironment "$usage" bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1; then
    buildFailed "$logFile" || return $?
  fi
  sleep 1 || :

  if ! assertDirectoryExists bin/build ||
    ! assertFileContains "$logFile" we-like-head-rubs.sh ||
    ! assertFileDoesNotContain "$logFile" "install-bin-build.sh" ||
    ! assertFileContains "$logFile" "we-like-head-rubs.sh" ||
    ! assertFileContains "$logFile" "is up to date" ||
    ! assertFileDoesNotContain "$logFile" "was updated" ||
    ! assertFileContains "$logFile" "does not ignore" ||
    ! assertFileContains "$logFile" ".gitignore"; then
    buildFailed "$logFile" || return $?
  fi
  rm -rf bin/build || :

  consoleSuccess Success, wanrnings were shown

  # --------------------------------------------------------------------------------
  #
  title="Has gitignore (good), needs update, different name"
  #
  section=$((section + 1))
  labeledBigText "$title" "Section #$section" || :
  logFile=$section.log

  assertDirectoryDoesNotExist bin/build || return $?

  echo "/bin/build/" >>.gitignore

  if ! __usageEnvironment "$usage" bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1; then
    buildFailed "$logFile" || return $?
  fi
  sleep 1 || :

  if ! assertDirectoryExists bin/build ||
    ! assertFileContains "$logFile" we-like-head-rubs.sh ||
    ! assertFileDoesNotContain "$logFile" "install-bin-build.sh" ||
    ! assertFileContains "$logFile" "is up to date" ||
    ! assertFileDoesNotContain "$logFile" "was updated" ||
    ! assertFileDoesNotContain "$logFile" "does not ignore" ||
    ! assertFileDoesNotContain "$logFile" ".gitignore"; then
    buildFailed "$logFile" || return $?
  fi

  rm -rf bin/build || :

  consoleSuccess Success
}
_setupGitTest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. setupGitTest "$@"
