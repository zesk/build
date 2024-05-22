#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

set -eou pipefail

export BUILD_COMPANY

if ! cd "$(dirname "${BASH_SOURCE[0]}")/../.."; then
  printf "%s\n" "cd failed" 1>&2
fi

fromTo=(bin/hooks/git-pre-commit.sh .git/hooks/pre-commit)
if ! diff -q "${fromTo[@]}" >/dev/null; then
  printf %s "Git pre-commit hook was updated ..."
  cp "${fromTo[@]}"
  exec "${fromTo[1]}" "$@"
fi

#
# The `git-pre-commit` hook will be installed as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# fn: {base}
hookGitPreCommit() {
  local this changedGitFiles changedShellFiles blank

  this="${FUNCNAME[0]}"

  # IDENTICAL loadSingles 9
  local single singles
  singles=()
  while read -r single; do
    single="${single#"${single%%[![:space:]]*}"}"
    single="${single%"${single##*[![:space:]]}"}"
    if [ "${single###}" = "${single}" ]; then
      singles+=(--single "$single")
    fi
  done <./etc/identical-check-singles.txt

  # shellcheck source=/dev/null
  if ! source "./bin/build/tools.sh"; then
    # poor man's clearLine
    blank=" "
    while [ ${#blank} -lt 80 ]; do
      blank="$blank$blank"
    done
    printf "\r%s\r%s\n" "$blank" "tools.sh failed" 1>&2
    return $errorEnvironment
  fi

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

  if [ ${#changedGitFiles[@]} -gt 0 ]; then
    printf -- "- %s\n" "${changedGitFiles[@]}"
  else
    return 0
  fi

  if [ -z "${BUILD_COMPANY-}" ]; then
    if ! buildEnvironmentLoad BUILD_COMPANY; then
      _hookGitPreCommitFailed "buildEnvironmentLoad BUILD_COMPANY failed" || return $?
    fi
    if [ -z "${BUILD_COMPANY-}" ]; then
      _hookGitPreCommitFailed "buildEnvironmentLoad BUILD_COMPANY is undefined" || return $?
    fi
  fi
  statusMessage consoleSuccess Making shell files executable ...
  if ! makeShellFilesExecutable >/dev/null; then
    _hookGitPreCommitFailed chmod-sh.sh || return $?
  fi
  statusMessage consoleSuccess Updating help files ...
  if ! ./bin/update-md.sh >/dev/null; then
    _hookGitPreCommitFailed update-md.sh || return $?
  fi
  if [ "${#changedShellFiles[@]}" -gt 0 ]; then
    statusMessage consoleSuccess Running shellcheck ...
    if ! validateShellScripts --interactive --exec contextOpen "${changedShellFiles[@]}"; then
      _hookGitPreCommitFailed validateShellScripts || return $?
    fi
    year=$(date +%Y)
    # shellcheck source=/dev/null
    if ! validateFileContents --exec contextOpen "${changedShellFiles[@]}" -- "Copyright &copy; $year" "$BUILD_COMPANY"; then
      _hookGitPreCommitFailed "Enforcing copyright and company in shell files" || return $?
    fi
    # Unusual quoting here is to avoid having this match as an identical
    if ! identicalCheck "${singles[@]+"${singles[@]}"}" --exec contextOpen --prefix '# ''IDENTICAL' --extension sh; then
      _hookGitPreCommitFailed identical-check.sh || return $?
    fi

    if ! findUncaughtAssertions test/tools --list; then
      findUncaughtAssertions test/tools --exec contextOpen &
      _hookGitPreCommitFailed findUncaughtAssertions || return $?
    fi
    if ! findUncaughtAssertions bin/build --list; then
      findUncaughtAssertions bin/build --exec contextOpen &
      _hookGitPreCommitFailed findUncaughtAssertions || return $?
    fi
  fi
  # Too slow
  #  if ! ./bin/build-docs.sh; then
  #    _hookGitPreCommitFailed build-docs.sh
  #  fi
  clearLine
}
_hookGitPreCommitFailed() {
  printf "%s: %s\n" "$(consoleError "Pre Commit Check Failed")" "$(consoleValue "$*")"
  return "$errorEnvironment"
}

hookGitPreCommit "$@"
