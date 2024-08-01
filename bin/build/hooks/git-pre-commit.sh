#!/usr/bin/env bash
#
# Part of build system integration with git
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

# IDENTICAL __where 10
# Summary: Locates application home depending on whether this is running as a git hook or not
# Usage: {fn}
# If current path contains `.git/` then print `../../..` otherwise print `../..`
# Lets us know if default hooks are in starting directory or are running as a git hook
__where() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}/"
  [ "${here%%.git/*}" != "$here" ] || printf "%s" "../"
  printf "%s" "../.."
}

# IDENTICAL _return 19
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
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# END of IDENTICAL _return

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

  export BUILD_PRECOMMIT_EXTENSIONS APPLICATION_NAME
  __usageEnvironment "$usage" buildEnvironmentLoad APPLICATION_NAME BUILD_PRECOMMIT_EXTENSIONS || return $?

  read -r -a extensions < <(printf "%s" "$BUILD_PRECOMMIT_EXTENSIONS")
  __usageEnvironment "$usage" gitInstallHook pre-commit || return $?

  consoleInfo "$(lineFill '*' "$APPLICATION_NAME ")"
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
