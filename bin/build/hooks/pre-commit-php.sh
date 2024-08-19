#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"

#
# The `git-pre-commit` hook self-installs as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# It will:
# 1. Updates the help file templates
# 2. Checks all shell files for errors
# fn: {base}
__hookPreCommitPHP() {
  local file changed
  local usage="_${FUNCNAME[0]}"
  local home

  home=$(__usageEnvironment "$usage" buildHome) || return $?

  printf "\n"
  __usageEnvironment "$usage" gitPreCommitListExtension php | wrapLines "- $(consoleBoldBlue)" "$(consoleReset)"

  if [ ! -d "$home/vendor" ]; then
    consoleInfo "PHP commit - no vendor directory - no fixer"
    return $?
  fi

  changed=()
  while read -r file; do changed+=("$file"); done < <(gitPreCommitListExtension php)
  if [ ! -x "$home/vendor/bin/php-cs-fixer" ]; then
    clearLine
    _environment "No php-cs-fixer found" || return $?
  fi
  statusMessage consoleSuccess "Fixing PHP"
  fixResults=$(mktemp)
  "$home/vendor/bin/php-cs-fixer" fix --allow-risky=yes "${changed[@]}" ou >"$fixResults" 2>&1 || __failEnvironment "$usage" "php-cs-fixer failed: $(cat "$fixResults")" || _clean $? "$fixResults" || return $?
  if grep -q 'not fixed' "$fixResults"; then
    clearLine
    grep -A 100 'not fixed' "$fixResults" | wrapLines "$(consoleError)" "$(consoleReset)"
    rm -f "$fixResults"
    _environment "PHP files failed" || return $?
  fi
  rm -f "$fixResults" || :

}
___hookPreCommitPHP() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../../.. __hookPreCommitPHP "$@"
