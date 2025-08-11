#!/usr/bin/env bash
#
# __fast.sh
#
# ORIGINAL of __check patterns which can be removed to speed things up
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.

function __faster() {
  # __IDENTICAL__ __checkHelp1FUNCNAME 1
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  local __handler="_${FUNCNAME[0]}"

  # __IDENTICAL__ __checkHelp1__handler 1
  [ "${1-}" != "--help" ] || __help "$__handler" "$@" || return 0

  local __count=$# __saved=("$@")

  local code="$1" && shift
  local command="$1" && shift
  # __IDENTICAL__ __checkCode__handler 1
  isInteger "$code" || __throwArgument "$__handler" "Not integer: $(decorate value "[$code]") (#$__count $(decorate each code "${__saved[@]}"))" || return $?
  # __IDENTICAL__ __checkHandler 1
  isFunction "$__handler" || _argument "handler not callable \"$(decorate code "$__handler")\"" || return $?
  # __IDENTICAL__ __checkCommand__handler 1
  isCallable "$command" || __throwArgument "$__handler" "Not callable $(decorate code "$command")" || return $?
}
