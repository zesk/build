#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 12
# Load tools.sh and run command
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

#
# The `git-pre-commit` hook self-installs as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# It will:
# 1. Updates the help file templates
# 2. Checks all shell files for errors
# fn: {base}
__hookGitPreCommit() {
  local file changed
  local usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" gitInstallHook pre-commit || return $?

  gitPreCommitSetup || :

  __usageEnvironment "$usage" runOptionalHook pre-commit || return $?

  gitPreCommitHeader sh md json

  if gitPreCommitHasExtension sh; then

    gitPreCommitListExtension sh | prefixLines "- $(consoleCode)" "$(consoleReset)"
    changed=()
    while read -r file; do changed+=("$file"); done < <(gitPreCommitListExtension sh)

    __usageEnvironment "$usage" gitPreCommitShellFiles --check test/tools --check bin/build --singles ./etc/identical-check-singles.txt "${changed[@]}" || return $?
    __usageEnvironment "$usage" identicalCheckShell --repair bin/build/identical --singles ./etc/identical-check-singles.txt "${changed[@]}" || return $?
  fi

  gitPreCommitCleanup || :

  # Too slow
  #  if ! ./bin/build-docs.sh; then
  #    _hookGitPreCommitFailed build-docs.sh
  #  fi
  clearLine || :
}
___hookGitPreCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. __hookGitPreCommit "$@"
