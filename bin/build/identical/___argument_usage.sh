#!/bin/bash
#
# argument_usage
#
# Template for developerDevelopmentLink implementations
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# DEPRECATED 2025-07
#
# Moving to universally using thet term 'handler' instead of 'usage' in code.
#
function __argumentsWithUsage() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --reset | --copy) ;;

    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
}
