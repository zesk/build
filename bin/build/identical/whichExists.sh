#!/bin/bash
#
# Original of whichExists
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL whichExists EOF

# Summary: Does a binary exist in the PATH?
# Argument: --any - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist.
# Argument: binary ... - Required. String. One or more Binaries to find in the system `PATH`.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: 0 - If all values are found
# Return Code: 1 - If any value is not found
# Requires: __throwArgument which decorate __decorateExtensionEach
whichExists() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$# anyFlag=false
  [ $# -gt 0 ] || __throwArgument "$handler" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --any) anyFlag=true ;;
    *)
      command which "$1" >/dev/null 2>&1 || return 1
      ! $anyFlag || return 0
      ;;
    esac
    shift
  done
}
_whichExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
