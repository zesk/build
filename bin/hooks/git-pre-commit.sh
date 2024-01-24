#!/usr/bin/env bash
#
# cp ./bin/hooks/git-pre-commit.sh .git/hooks/pre-commit
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

failed() {
  printf "%s: %s\n" "$(consoleError "Pre Commit Check Failed")" "$(consoleValue "$*")"
  exit "$errorEnvironment"
}

#
# The `git-pre-commit` hook will be installed as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# fn: {base}
hookGitPreCommit() {
  local ignorePaths=(! -path '*/vendor/*')

  statusMessage consoleSuccess Making shell files executable ...
  if ! ./bin/build/chmod-sh.sh >/dev/null; then
    failed chmod-sh.sh
  fi
  statusMessage consoleSuccess Updating help files ...
  if ! ./bin/update-md.sh >/dev/null; then
    failed update-md.sh
  fi
  statusMessage consoleSuccess Running shellcheck ...
  if ! testShellScripts "${ignorePaths[@]}"; then
    failed testShellScripts
  fi
  # Unusual quoting here is to avoid having this match as an identical
  if ! ./bin/build/identical-check.sh --prefix '# ''IDENTICAL' --extension sh; then
    failed identical-check.sh
  fi
#  if ! ./bin/build-docs.sh; then
#    failed build-docs.sh
#  fi
  clearLine

}

hookGitPreCommit "$@"
