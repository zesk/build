#!/bin/bash
#
# Identical template
#
# Original of __help
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Requires: IDENTICAL _return
# Does NOT require IDENTICAL __execute as `tools.sh` supplies that as well

# IDENTICAL __help EOF
# Usage: {fn} [ --only ] usageFunction arguments
# Simple help argument handler.
#
# Easy `--help` handler for any function useful when it's the only option.
#
# Useful for utilities which single argument types, single arguments, and no arguments (except for `--help`)
#
# Oddly one of the few functions we can not offer the `--help` flag for.
#
# Argument: --only - Flag. Optional. Must be first parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Example:     __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     __help "$usage" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
# Depends: __throwArgument
__help() {
  local usage="${1-}" && shift
  if [ "$usage" = "--only" ]; then
    usage="${1-}" && shift
    [ "$#" -eq 1 ] && [ "$1" = "--help" ] || __throwArgument "$usage" "Only argument allowed is \`--help\`" || return $?
  fi
  while [ $# -gt 0 ]; do
    if [ "$1" = "--help" ]; then
      "$usage" 0
      return 1
    fi
    shift
  done
  return 0
}
