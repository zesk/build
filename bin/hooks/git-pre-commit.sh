#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __loader 11
set -eou pipefail
# Load zesk build and run command
__loader() {
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
}

#
# The `git-pre-commit` hook will be installed as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# fn: {base}
__hookGitPreCommit() {
  local this file changed total
  local this="${FUNCNAME[0]}" usage="${FUNCNAME[0]#_}"

  # shellcheck source=/dev/null
  __usageEnvironment "$usage" gitInstallHook pre-commit || return $?

  changedLists=$(mktemp -d) || __failEnvironment "$usage" mktemp -d || return $?

  __usageEnvironment "$usage" extensionLists --clean "$changedLists" <(git diff --name-only --cached --diff-filter=ACMR) || return $?

  total=$(($(wc -l <"$changedLists/@") + 0)) || __failEnvironment "$usage" "wc -l" || return $?

  printf "%s%s: %s\n" "$(clearLine)" "$(consoleSuccess "$this")" "$(consoleInfo "$total $(plural "$total" file files) changed")"

  statusMessage consoleSuccess Updating help files ...
  __usageEnvironment "$usage" ./bin/update-md.sh || return $?

  if [ -f "$changedLists/sh" ]; then
    prefixLines "- $(consoleCode)" "$(consoleReset)" <"$changedLists/sh"
  else
    return 0
  fi
  if [ -f "$changedLists/sh" ]; then
    changed=()
    while read -r file; do changed+=("$file"); done <"$changedLists/sh"
    __usageEnvironment "$usage" gitPreCommitShellFiles --check test/tools --check bin/build --singles ./etc/identical-check-singles.txt "${changed[@]}" || return $?
  fi

  # Too slow
  #  if ! ./bin/build-docs.sh; then
  #    _hookGitPreCommitFailed build-docs.sh
  #  fi
  clearLine
}
_hookGitPreCommit() {
  _fail "$(printf "%s: %s\n" "$(consoleError "Pre Commit Check Failed")" "$(consoleValue "$*")")" || return $?
}

__loader __hookGitPreCommit "$@"
