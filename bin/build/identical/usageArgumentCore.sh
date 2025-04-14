#!/bin/bash
#
# Identical template
#
# Original of usageArgumentCore
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL usageArgumentCore EOF

# Require an argument to be non-blank
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be non-blank otherwise an argument error is thrown.
# Exit Code: 2 - If `value` is blank
# Exit code: 0 - If `value` is non-blank
usageArgumentString() {
  local usage="$1" argument="$2"
  shift 2 || :
  [ -n "${1-}" ] || __throwArgument "$usage" "blank" "$argument" || return $?
  printf "%s\n" "$1"
}
