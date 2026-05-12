#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of inArray
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL inArray EOF

# Check if an element exists in an array
#
# Argument: element - EmptyString. Thing to search for
# Argument: arrayElement0 ... - Array. Optional. One or more array elements to match
# Example:     if inArray "$thing" "${things[@]+"${things[@]}"}"; then
# Example:         things+=("$thing")
# Example:     fi
# Return Code: 0 - If element is found in array
# Return Code: 1 - If element is NOT found in array
# Tested: No
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
inArray() {
  local element=${1-} arrayElement
  if ! shift 2>/dev/null; then
    _inArray 0 && return $? || return $?
  fi
  for arrayElement; do
    if [ "$element" == "$arrayElement" ]; then
      return 0
    fi
  done
  return 1
}
_inArray() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
