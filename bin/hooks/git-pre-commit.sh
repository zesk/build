#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

fromTo=(bin/hooks/git-pre-commit.sh .git/hooks/pre-commit)
if ! diff -q "${fromTo[@]}" >/dev/null; then
  printf %s "Git pre-commit hook was updated ..."
  cp "${fromTo[@]}"
  exec .git/hooks/pre-commit "$@"
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

changedGitFiles=()
changedShellFiles=()
while IFS= read -r changedGitFile; do
  changedGitFiles+=("$changedGitFile")
  if [ "$changedGitFile" != "${changedGitFile%.sh}" ]; then
    changedShellFiles+=("$changedGitFile")
  fi
done < <(git diff --name-only --cached --diff-filter=ACMR)

consoleInfo "${#changedGitFiles[@]} $(plural ${#changedGitFiles[@]} file files) changed"

_hookGitPreCommitFailed() {
  printf "%s: %s\n" "$(consoleError "Pre Commit Check Failed")" "$(consoleValue "$*")"
  exit "$errorEnvironment"
}

#
# The `git-pre-commit` hook will be installed as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# fn: {base}
hookGitPreCommit() {
  statusMessage consoleSuccess Making shell files executable ...
  if ! ./bin/build/chmod-sh.sh >/dev/null; then
    _hookGitPreCommitFailed chmod-sh.sh
  fi
  statusMessage consoleSuccess Updating help files ...
  if ! ./bin/update-md.sh >/dev/null; then
    _hookGitPreCommitFailed update-md.sh
  fi
  if [ "${#changedShellFiles[@]}" -gt 0 ]; then
    statusMessage consoleSuccess Running shellcheck ...
    if ! validateShellScripts --exec contextOpen "${changedShellFiles[@]}"; then
      _hookGitPreCommitFailed validateShellScripts
    fi
    year=$(date +%Y)
    # shellcheck source=/dev/null
    source ./bin/build/env/BUILD_COMPANY.sh
    if ! validateFileContents --exec contextOpen "${changedShellFiles[@]}" -- "Copyright &copy; $year" "$BUILD_COMPANY"; then
      _hookGitPreCommitFailed "Enforcing copyright and company in shell files"
    fi
    # Unusual quoting here is to avoid having this match as an identical
    if ! identicalCheck --exec contextOpen --prefix '# ''IDENTICAL' --extension sh; then
      _hookGitPreCommitFailed identical-check.sh
    fi
  fi
  # Too slow
  #  if ! ./bin/build-docs.sh; then
  #    _hookGitPreCommitFailed build-docs.sh
  #  fi
  clearLine
}

hookGitPreCommit "$@"
