#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# mock.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Fake conditions to test them

# Saved name should not match grep of argument
__mockEnvironmentGlobal() {
  printf "%s\n" "__MOCK_${1:0:1}_${1:1}_"
}

# Saved value should not match grep of argument
__mockEnvironmentEmpty() {
  printf "%s\n" "__EMPTY__ _${1:0:1}_${1:1}_"
}

__mockEnvironmentStart() {
  local handler="$1" && shift

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  while [ $# -gt 0 ]; do
    local argument="${1-}" && shift
    __mockVariableStart "$argument" "${1-}"
    [ $# -eq 0 ] || shift
  done
}

__mockEnvironmentStop() {
  local handler="$1" && shift
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *)
      __mockVariableStop "$argument"
      ;;
    esac
    shift
  done
}

__mockVariableStart() {
  local argument="$1"
  local value="$2"
  local emptyValue && emptyValue="$(__mockEnvironmentEmpty "$argument")"
  local saveGlobal && saveGlobal="$(__mockEnvironmentGlobal "$argument")"
  statusMessage --last decorate notice "MOCK: Saving $argument"
  # shellcheck disable=SC2163
  export "$saveGlobal"="${!argument-"$emptyValue"}"
  export "$argument"="$value"
}

__mockVariableStop() {
  local argument="$1"
  local emptyValue && emptyValue="$(__mockEnvironmentEmpty "$argument")"
  local saveGlobal && saveGlobal="$(__mockEnvironmentGlobal "$argument")"
  # shellcheck disable=SC2163
  export "$argument"
  if [ "${!saveGlobal-"$emptyValue"}" = "$emptyValue" ]; then
    unset "$argument"
    statusMessage --last decorate notice "MOCK: Removing $argument (was unset)"
  else
    local value="${!saveGlobal-}"
    export "$argument"="$value"
    statusMessage --last decorate notice "MOCK: Restoring $argument ($(localePluralWord "${#value}" character))"
  fi
  unset "$saveGlobal"
}

__mockConsoleAnimationStart() {
  local handler="$1" && shift
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local flag && flag=$(validate "$handler" Boolean "flag" "${1-}") || return $?
  __mockVariableStart CI "$(booleanChoose "$flag" "" "testCI")" || return $?
}

__mockConsoleAnimationStop() {
  local handler="$1" && shift
  [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  __mockVariableStop CI
}
