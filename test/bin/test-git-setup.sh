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

# IDENTICAL _return 15
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[0]} non-integer $r" "$@" || return $?
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

  rm -rf bin/build || return $?

  consoleSuccess Success

  # --------------------------------------------------------------------------------
  #
  boxedHeading "Has gitignore (missing), missing, different name"
  section=$((section + 1))
  bigText "Section #$section"

  #  ▞▀▖      ▐  ▗           ▞▀▖
  #  ▚▄ ▞▀▖▞▀▖▜▀ ▄ ▞▀▖▛▀▖ ▟▟▖ ▗▘
  #  ▖ ▌▛▀ ▌ ▖▐ ▖▐ ▌ ▌▌ ▌ ▟▟▖▗▘
  #  ▝▀ ▝▀▘▝▀  ▀ ▀▘▝▀ ▘ ▘ ▝▝ ▀▀▘

  assertDirectoryDoesNotExist --line "$LINENO" bin/build || return $?

  touch .gitignore || return $?
  mv bin/pipeline/install-bin-build.sh bin/pipeline/we-like-head-rubs.sh || return $?

  # Test
  matches=(
    --stdout-match "we-like-head-rubs.sh"
    --stdout-no-match "install-bin-build.sh"

    --stdout-match "Installed"
    --stdout-no-match "already installed"

    --stdout-match "does not ignore"
    --stdout-match ".gitignore"
  )
  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" || return $?

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
_setupGitTest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. setupGitTest "$@"
