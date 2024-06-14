#!/usr/bin/env bash
#
# Part of build system integration with git
#
# This file name MUST be prefixed with `git-` and suffixed with `.sh` and the remainder should
# be the `git` `.git/hook/` name.
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
# The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
# overwrite any existing `post-commit` hook.
#
# fn: {base}
hookGitPostCommit() {
  local usage="_${FUNCNAME[0]}"

  # shellcheck source=/dev/null
  source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh" || _fail tools.sh || return $?

  __usageEnvironment "$usage" gitInstallHook --verbose post-commit || return $?

  __usageEnvironment "$usage" gitMainly || return $?
}
_hookGitPostCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

hookGitPostCommit "$@"
