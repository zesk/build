#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 12
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

# IDENTICAL __where 7
# Locates bin/build depending on whether this is running as a git hook or not
__where() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  [ "${here%%.git*}" != "$here" ] || printf "%s" "../"
  printf "%s" "../.."
}

#
# The `git-pre-commit` hook self-installs as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.`
#
# It will:
# 1. Updates the help file templates
# 2. Checks all shell files for errors
# fn: {base}
__hookGitPreCommit() {
  local usage="_${FUNCNAME[0]}"
  local extension extensions

  export BUILD_PRECOMMIT_EXTENSIONS
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_PRECOMMIT_EXTENSIONS || return $?

  read -r -a extensions < <(printf "%s" "$BUILD_PRECOMMIT_EXTENSIONS")
  __usageEnvironment "$usage" gitInstallHook pre-commit || return $?

  gitPreCommitSetup || :
  __usageEnvironment "$usage" runOptionalHook pre-commit || return $?

  for extension in "${extensions[@]+${extensions[@]}}"; do
    statusMessage consoleInfo "Processing $(consoleCode "$extension") ..."
    if gitPreCommitHasExtension "$extension"; then
      __usageEnvironment "$usage" runOptionalHook "pre-commit-$extension" || return $?
    fi
    clearLine
  done

  gitPreCommitCleanup || :
  clearLine || :
}
___hookGitPreCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools "$(__where)" __hookGitPreCommit "$@"
