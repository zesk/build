#!/usr/bin/env bash
#
# Identical template
#
# argument-case-blank-argument-header
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

___documentTemplateFunction() {
  local handler="_${FUNCNAME[0]}"

  local manager=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) ! "$handler" 0 || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  return 0
}
