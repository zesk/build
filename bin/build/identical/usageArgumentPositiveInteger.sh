#!/bin/bash
#
# Identical template
#
# Original of usageArgumentCore
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL usageArgumentPositiveInteger EOF

# Validates a value is an positive integer and greater than zero (NOT zero)
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Return Code: 2 - Argument error
# Return Code: 0 - Success
# Requires: isPositiveInteger throwArgument decorate
usageArgumentPositiveInteger() {
  local handler="$1"
  [ $# -eq 3 ] || throwArgument "$handler" "${FUNCNAME[0]} Need 3 arguments ($#)" || return $?
  shift && isPositiveInteger "${2-}" || throwArgument "$handler" "${1-} not a positive integer: $(decorate code "${2-}")" || return $?
  printf "%s\n" "$2"
}
