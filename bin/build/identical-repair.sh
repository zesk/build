#!/usr/bin/env bash
#
# identical-repair.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __source 19
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
__source() {
  local me="${BASH_SOURCE[0]}" e=253
  local here="${me%/*}" a=()
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  while [ $# -gt 0 ]; do a+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 25
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf
_return() {
  local r="${1-:1}" && shift
  isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf -- "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return
# <-- END of IDENTICAL _return

# fn: {base}
# Usage: {fn}
# By default will add any directory named `identical` as repair source and any file
# at `identical/singles.txt` as a singles file.
#
# Failures will be opened using `contextOpen`.
#
# See `identicalCheckShell` for additional arguments and usage.
# See: identicalCheckShell
__buildIdenticalRepair() {
  local usage="_${FUNCNAME[0]}"
  local item aa home

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  __catchEnvironment "$usage" muzzle cd "$home" || return $?
  local done=false aa=()
  while ! $done; do
    read -r item || done=true
    [ -z "$item" ] || aa+=(--singles "$item")
  done < <(find . -name 'singles.txt' -path '*/identical/*' ! -path "*/.*/*")
  done=false
  while ! $done; do
    read -r item || done=true
    [ -z "$item" ] || aa+=(--repair "$item")
  done < <(find "$home" -type d -name identical ! -path "*/.*/*")
  bashDebugInterruptFile --error --interrupt
  set -eou pipefail
  __catchEnvironment "$usage" identicalCheckShell --skip "$(realPath "${BASH_SOURCE[0]}")" "${aa[@]+"${aa[@]}"}" --exec contextOpen "$@" || return $?
}
___buildIdenticalRepair() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. __buildIdenticalRepair "$@"
