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

# IDENTICAL __tools 18
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local relative="${1:-".."}"
  local source="${BASH_SOURCE[0]}" internalError=253
  local here="${source%/*}"
  local tools="$here/$relative/bin/build"
  [ -d "$tools" ] || _return $internalError "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $internalError "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $internalError source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}

# IDENTICAL _return 14
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift && : || _integer "$r" || _return 2 "${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() { case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac }

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
