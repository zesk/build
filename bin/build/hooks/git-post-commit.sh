#!/usr/bin/env bash
#
# Part of build system integration with git
#
# This file name MUST be prefixed with `git-` and suffixed with `.sh` and the remainder should
# be the `git` `.git/hook/` name.
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
# The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
# overwrite any existing `post-commit` hook.
#
# Merges `main` and `staging` and pushes to `origin`
#
# fn: {base}
__hookGitPostCommit() {
  local usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" gitInstallHook post-commit || return $?
  __usageEnvironment "$usage" runOptionalHook post-commit || return $?
  __usageEnvironment "$usage" gitMainly || return $?
  __usageEnvironment "$usage" git push origin || return $?
}
___hookGitPostCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools "$(__where)" __hookGitPostCommit "$@"
