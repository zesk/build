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
  __usageEnvironment "$usage" gitPreCommitListExtension php | wrapLines "- $(decorate bold-blue)" "$(consoleReset)"

  if [ ! -d "$home/vendor" ]; then
    decorate info "PHP commit - no vendor directory - no fixer"
    return $?
  fi

  changed=()
  while read -r file; do changed+=("$file"); done < <(gitPreCommitListExtension php)
  if [ ! -x "$home/vendor/bin/php-cs-fixer" ]; then
    clearLine
    __failEnvironment "$usage" "No php-cs-fixer found" || return $?
  fi
  if [ ! -f "$home/.php-cs-fixer.php" ]; then
    clearLine
    __failEnvironment "$usage" "No .php-cs-fixer.php found" || return $?
  fi
  statusMessage decorate success "Fixing PHP"
  fixResults=$(mktemp)

  "$home/vendor/bin/php-cs-fixer" fix --config "$home/.php-cs-fixer.php" "${changed[@]}" >"$fixResults" 2>&1 || __failEnvironment "$usage" "php-cs-fixer failed: $(cat "$fixResults")" || _clean $? "$fixResults" || return $?
  if grep -q 'not fixed' "$fixResults"; then
    clearLine
    grep -A 100 'not fixed' "$fixResults" | wrapLines "$(decorate error)" "$(consoleReset)"
    rm -f "$fixResults"
    __failEnvironment "$usage" "PHP files failed" || return $?
  fi
  clearLine
  decorate success "PHP fixer ran"
  rm -f "$fixResults" || :

}
___hookPreCommitPHP() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookPreCommitPHP "$@"
