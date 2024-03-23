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
set -eou pipefail

#
# fn: {base}
# Usage: {fn} buildHome
#
setupGitTest() {
  buildHome=$1
  shift || :

  # shellcheck source=/dev/null
  . "$buildHome/bin/build/tools.sh"

  local testDir testBinBuild title section logFile
  local errorEnvironment=1

  section=0
  testDir=$(mktemp -d)
  testBinBuild="$testDir/bin/pipeline/install-bin-build.sh"
  if ! cd "$testDir"; then
    _setupGit "$errorEnvironment" "cd $testDir failed"
  fi

  if ! mkdir -p bin/pipeline; then
    _setupGit "$errorEnvironment" "cd $testDir failed"
  fi
  cp "$buildHome/bin/build/install-bin-build.sh" "$testBinBuild"
  echo '# this make the file different' >>"$testBinBuild"

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

  if ! bin/pipeline/install-bin-build.sh --mock "$buildHome/bin/build" >"$logFile" 2>&1; then
    buildFailed "$logFile" || :
    _setupGit "$errorEnvironment" "install-bin-build.sh failed"
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

  if ! bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1; then
    buildFailed "$logFile"
    _setupGit "$errorEnvironment" "install-bin-build.sh failed" || return $?
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
    buildFailed "$logFile" || :
    _setupGit "$errorEnvironment" "install-bin-build.sh failed"
    return $?
  fi
  rm -rf bin/build

  consoleSuccess Success, wanrnings were shown

  # --------------------------------------------------------------------------------
  #
  title="Has gitignore (good), needs update, different name"
  #
  section=$((section + 1))
  labeledBigText "$title" "Section #$section"
  logFile=$section.log

  assertDirectoryDoesNotExist bin/build || return $?

  echo "/bin/build/" >>.gitignore

  if ! bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1; then
    buildFailed "$logFile"
    _setupGit "$errorEnvironment" "install-bin-build.sh failed" || return $?
  fi
  sleep 1 || :

  if ! assertDirectoryExists bin/build ||
    ! assertFileContains "$logFile" we-like-head-rubs.sh ||
    ! assertFileDoesNotContain "$logFile" "install-bin-build.sh" ||
    ! assertFileContains "$logFile" "is up to date" ||
    ! assertFileDoesNotContain "$logFile" "was updated" ||
    ! assertFileDoesNotContain "$logFile" "does not ignore" ||
    ! assertFileDoesNotContain "$logFile" ".gitignore"; then
    buildFailed "$logFile"
    _setupGit "$errorEnvironment" "install-bin-build.sh failed" || return $?
  fi

  rm -rf bin/build || :

  consoleSuccess Success
}
_setupGitTest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

setupGitTest "$@"
