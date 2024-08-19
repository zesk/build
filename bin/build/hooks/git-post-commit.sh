#!/usr/bin/env bash
#
# Part of build system integration with git
#
# This file name MUST be prefixed with `git-` and suffixed with `.sh` and the remainder should
# be the `git` `.git/hook/` name.
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# DOES NOT USE zesk-build-hook-header because this may be installed as a git hook as well so
# it determines where it is installed and finds the build directory appropriately

# IDENTICAL __tools 16
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local source="${BASH_SOURCE[0]}" e=253
  local here="${source%/*}" arguments=()
  local tools="$here/${1:-".."}/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh" && [ -x "$tools" ] || _return $e "$tools not executable" "$@" || return $?
  shift && while [ $# -gt 0 ]; do arguments+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" "$@" || return $?
  [ ${#arguments[@]} -gt 0 ] || return 0
  "${arguments[@]}" || return $?
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
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__gitPushHelper() {
  local usage="$1"
  local tempFile

  tempFile=$(mktemp) || __failEnvironment "$usage" "__gitPushHelper mktemp" || return $?
  if ! __usageEnvironment "$usage" git push origin 2>&1 | tee "$tempFile" | grep 'remote:' | removeFields 1 | wrapLines "Remote: $(consoleCode)" "$(consoleReset)"; then
    if ! grep -q 'up-to-date' "$tempFile"; then
      dumpPipe "git push" <"$tempFile" || :
      __environment rm -rf "$tempFile" || :
      return 1
    fi
  fi
  __environment rm -rf "$tempFile" || :
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
  clearLine
  __usageEnvironment "$usage" gitInstallHook post-commit || return $?
  __usageEnvironment "$usage" runOptionalHook post-commit || return $?
  __gitPushHelper "$usage" || return $?
  # __usageEnvironment "$usage" gitMainly || return $?
  __gitPushHelper "$usage" || return $?
}
___hookGitPostCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools "$(__where)" __hookGitPostCommit "$@"
