#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# stderr-ok
#
# shellcheck source=/dev/null

# IDENTICAL __source 21

# Load a source file and run a command
# Argument: source - File. Required. Path to source relative to application root..
# Argument: relativeHome - Directory. Optional. Path to application root. Defaults to `..`
# Argument: command ... - Callable. Optional. A command to run and optional arguments.
# Requires: returnMessage
# Security: source
# Return Code: 253 - source failed to load (internal error)
# Return Code: 0 - source loaded (and command succeeded)
# Return Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || returnMessage $e "missing source" || return $?
  [ -d "${source%/*}" ] || returnMessage $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || returnMessage $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || returnMessage $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Directory. Required. Path to application root.
# Argument: command ... - Callable. Optional. A command to run and optional arguments.
# Requires: __source
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL returnMessage 32

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.
# Argument: message ... - String. Optional. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf returnMessage
returnMessage() {
  local h="_${FUNCNAME[0]}" c="${1:-1}" && shift 2>/dev/null
  if [ "$c" = "--help" ]; then "$h" 0 && return 0 || return $?; fi
  # __IDENTICAL__ localTrace 1
  local trace="§ ${BASH_SOURCE[1]#"${BUILD_HOME-}/"}:${BASH_LINENO[0]-} ${FUNCNAME[1]}"
  isUnsignedInteger "$c" || returnMessage 2 "${h#_} non-integer \"$c\" ($trace)" "$@" || return $?
  if [ "$c" != "0" ]; then printf "%s [%s] %s (%s)\n" "❌" "$c" "${*-§}" "$trace" 1>&2; else printf "%s %s\n" "✅" "${*-§}"; fi && return "$c"
}
_returnMessage() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Is value an unsigned integer?
# Test if a value is a 0 or greater integer. Leading "+" is ok.
# See: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: returnMessage
isUnsignedInteger() {
  [ $# -eq 1 ] || returnMessage 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL returnMessage

# Lay an egg
layAnEgg() {
  local hay=""

  if [ -z "$hay" ]; then
    _layAnEgg 1 "No hay" || return $?
  fi
}
_layAnEgg() {
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. layAnEgg "$@" || :

# fn: makeCryptoThing
# Lay an egg.
#
# You can use `markdown` in *here*. **Cool**.
#
# The end.
#
# Argument: name - String. Required. What to name the egg.
# Argument: --debug - Flag. Optional. Turn on debugging.`
# Return Code: 0 - Success
# Return Code: 1 - Environment error
# Return Code: 2 - Argument error
# Example: {fn} newEgg
# Output: Eggs laid: 2000git
layAnEgg2() {
  _layAnEgg2 0 "All is great"
}
_layAnEgg2() {
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. layAnEgg2
