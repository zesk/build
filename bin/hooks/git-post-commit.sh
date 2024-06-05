#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

# Output a titled list
# Usage: {fn} title [ items ... ]
_list() {
  local title
  title="${1-"$emptyArgument"}" && shift && printf "%s\n%s\n" "$title" "$(printf -- "- %s\n" "$@")"
}

# Critical exit `errorCritical` - exit immediately
# Usage: {fn} {title} [ items ... ]
_fail() {
  local errorCritical=99
  local title="${1-"$emptyArgument"}"
  export BUILD_DEBUG
  # shellcheck disable=SC2016
  exec 1>&2 && shift && _list "$title" "$(printf '%s ' "$@")"
  if "${BUILD_DEBUG-false}"; then
    _list "Stack" "${FUNCNAME[@]}" || :
    _list "Sources" "${BASH_SOURCE[@]}" || :
  fi
  return "$errorCritical"
}

#
# The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
# overwrite any existing `post-commit` hook.
#
# fn: {base}
hookGitPostCommit() {
  local fromTo

  if ! cd "$(dirname "${BASH_SOURCE[0]}")/../.."; then
    _fail "$(printf "%s\n" "cd failed")" "$@" || return $?
  fi

  fromTo=(bin/hooks/git-post-commit.sh .git/hooks/post-commit)
  if ! diff -q "${fromTo[@]}" >/dev/null; then
    printf "Git %s hook was updated" "$(basename "${fromTo[0]}")" && cp "${fromTo[@]}" && exec "${fromTo[1]}" "$@"
    _fail "$(printf "%s\n" "${fromTo[*]} failed")" "$@" || return $?
  fi

  # shellcheck source=/dev/null
  if ! source ./bin/build/tools.sh; then
    _fail "$(printf "%s\n" "${fromTo[*]} failed")" || return $?
  fi

  buildEnvironmentLoad BUILD_HOME || _hookGitPostCommitFailed "BUILD_HOME failed" || return $?

  gitMainly || _hookGitPostCommitFailed gitMainly || return $?
}
_hookGitPostCommitFailed() {
  _fail "$(printf "%s: %s\n" "$(consoleError "Pre Commit Check Failed")" "$(consoleValue "$*")")" || return $?
}

hookGitPostCommit "$@"
