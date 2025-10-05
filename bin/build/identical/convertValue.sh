#!/bin/bash
#
# Original of convertValue
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ convertValue EOF

# map a value from one value to another given from-to pairs
#
# Prints the mapped value to stdout
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: value - String. A value.
# Argument: from - String. When value matches `from`, instead print `to`
# Argument: to - String. The value to print when `from` matches `value`
# Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match
convertValue() {
  local __handler="_${FUNCNAME[0]}" value="" from="" to=""
  # __IDENTICAL__ __checkHelp1__handler 1
  [ "${1-}" != "--help" ] || __help "$__handler" "$@" || return 0

  while [ $# -gt 0 ]; do
    if [ -z "$value" ]; then
      value=$(usageArgumentString "$__handler" "value" "$1") || return $?
    elif [ -z "$from" ]; then
      from=$(usageArgumentString "$__handler" "from" "$1") || return $?
    elif [ -z "$to" ]; then
      to=$(usageArgumentString "$__handler" "to" "$1") || return $?
      if [ "$value" = "$from" ]; then
        printf "%s\n" "$to"
        return 0
      fi
      from="" && to=""
    fi
    shift
  done
  printf "%s\n" "${value:-0}"
}
_convertValue() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
