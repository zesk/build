#!/bin/bash
#
# Identical template
#
# Original of usageArgumentCore
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL usageArgumentCore EOF

# Require an argument to be non-blank
# Argument: handler - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be non-blank otherwise an argument error is thrown.
# Return Code: 2 - If `value` is blank
# Return Code: 0 - If `value` is non-blank
# Requires: throwArgument
usageArgumentString() {
  local handler="$1" argument="$2"
  shift 2 || :
  [ -n "${1-}" ] || throwArgument "$handler" "blank" "$argument" || return $?
  printf "%s\n" "$1"
}
