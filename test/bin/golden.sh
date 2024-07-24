#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# stderr-ok
#
# shellcheck source=/dev/null

# IDENTICAL __tools 18
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local relative="${1:-".."}"
  local source="${BASH_SOURCE[0]}" internalError=253
  local here="${source%/*}"
  local tools="$here/$relative/bin/build"
  [ -d "$tools" ] || _return $internalError "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $internalError "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $internalError source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}

# IDENTICAL _return 16
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() { case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac }
# END of IDENTICAL _return



# Lay an egg
layAnEgg() {
  local hay=""

  if [ -z "$hay" ]; then
    _layAnEgg 1 "No hay" || return $?
  fi
}
_layAnEgg() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. layAnEgg "$@" || :


# fn: makeCryptoThing
# Lay an egg.
#
# You can use `markdown` in *here*. **Cool**.
#
# The end.
#
# Argument: name - Required. String. What to name the egg.
# Argument: --debug - Optional. Flag. Turn on debugging.`
# Exit Code: 0 - Success
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
# Example: {fn} newEgg
# Output: Eggs laid: 2000git
layAnEgg2() {
  _layAnEgg2 0 "All is great"
}
_layAnEgg2() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. layAnEgg2
