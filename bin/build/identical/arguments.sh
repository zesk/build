#!/usr/bin/env bash
#
# Identical template
#
# argument-case-blank-argument-header
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

___documentTemplateFunction() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-blank-argument-header 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  return 0
}
