#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 17
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local source="${BASH_SOURCE[0]}" e=253
  local here="${source%/*}"
  local tools="$here/${1:-".."}/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $e "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

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
