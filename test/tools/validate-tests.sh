#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

_usageArgumentTypeList() {
  local prefix="usageArgument"
  declare -F | removeFields 2 | grepSafe -e "^$prefix" | cut -c "$((${#prefix} + 1))"- | sort
}

testValidateMissing() {
  local handler="_return"
  local usageTypes validateTypes

  usageTypes=$(fileTemporaryName "$handler") || return $?
  validateTypes=$(fileTemporaryName "$handler") || return $?

  __catchEnvironment "$handler" _usageArgumentTypeList >"$usageTypes" || return $?
  __catchEnvironment "$handler" validateTypeList >"$validateTypes" || return $?

  printf "%s %s\n" "$(decorate red "< usage")" "$(decorate green "> validate")"
  diff --suppress-common-lines "$usageTypes" "$validateTypes" | grepSafe -e '^[<>]' || :

  __catchEnvironment "$handler" rm -rf "$usageTypes" "$validateTypes" || return $?
}
