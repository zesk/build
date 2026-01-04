#!/usr/bin/env bash
#
# Identical template
#
# Original of isArray
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# _IDENTICAL_ isArray EOF

# Is a variable declared as an array?
# Argument: variableName - Required. String. Variable to check is an array.
isArray() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || return 1
    case "$(declare -p "${1-}" 2>/dev/null)" in
    *"declare -a"*) ;;
    *) return 1 ;;
    esac
    shift
  done
  return 0
}
_isArray() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
