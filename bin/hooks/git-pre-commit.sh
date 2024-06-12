#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

# Usage: {fn} {title} [ items ... ]
_fail() {
  exec 1>&2 && printf 'FAIL: %s\n' "$@"
  return 42 # The meaning of life
}

#
# The `git-pre-commit` hook will be installed as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# fn: {base}
hookGitPreCommit() {
  local this changedGitFiles changedShellFiles
  local this="${FUNCNAME[0]}" usage="_${FUNCNAME[0]}"

  # shellcheck source=/dev/null
  source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh" || _fail tools.sh || return $?
  __usageEnvironment "$usage" gitInstallHook pre-commit || return $?

  changedGitFiles=()
  changedShellFiles=()
  while IFS= read -r changedGitFile; do
    [ -n "$changedGitFile" ] || continue
    changedGitFiles+=("$changedGitFile")
    if [ "$changedGitFile" != "${changedGitFile%.sh}" ]; then
      changedShellFiles+=("$changedGitFile")
    fi
  done < <(git diff --name-only --cached --diff-filter=ACMR)

  clearLine
  printf "%s: %s\n" "$(consoleSuccess "$this")" "$(consoleInfo "${#changedGitFiles[@]} $(plural ${#changedGitFiles[@]} file files) changed")"

  statusMessage consoleSuccess Updating help files ...
  __usageEnvironment "$usage" ./bin/update-md.sh || return $?

  if [ ${#changedGitFiles[@]} -gt 0 ]; then
    printf -- "- %s\n" "${changedGitFiles[@]}"
  else
    return 0
  fi
  if [ "${#changedShellFiles[@]}" -gt 0 ]; then
    __usageEnvironment "$usage" gitPreCommitShellFiles --check test/tools --check bin/build --singles ./etc/identical-check-singles.txt "${changedShellFiles[@]}" || return $?
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

hookGitPreCommit "$@"
