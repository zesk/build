#!/usr/bin/env bash
#
# Identical template
#
# Original of isArray
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ isArray EOF

# Is a variable declared as an array?
# Argument: variableName - Required. String. Variable to check is an array.
isArray() {
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
