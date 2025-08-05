#!/bin/bash
#
# Original of whichExists
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL whichExists EOF

# Summary: Does a binary exist in the PATH?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: binary ... - Required. String. One or more Binaries to find in the system `PATH`.
# Exit code: 0 - If all values are found
# Exit code: 1 - If any value is not found
# Requires: __throwArgument which decorate __decorateExtensionEach
whichExists() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local __saved=("$@") __count=$#
  [ $# -gt 0 ] || __throwArgument "$handler" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}
_whichExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
