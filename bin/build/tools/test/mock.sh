#!/usr/bin/env bash
#
# mock.sh
#
# Fake conditions to test them
#
# Copyright &copy; 2026 Market Acumen, Inc.

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
  while [ $# -gt 0 ]; do
    local argument="${1-}" && shift
    local value="${1-}"
    [ $# -eq 0 ] || shift
    local emptyValue saveGlobal
    emptyValue="$(__mockEnvironmentEmpty "$argument")"
    saveGlobal="$(__mockEnvironmentGlobal "$argument")"
    statusMessage --last decorate notice "MOCK: Saving $argument"
    # shellcheck disable=SC2163
    export "$saveGlobal"="${!argument-"$emptyValue"}"
    export "$argument"="$value"
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
      local emptyValue saveGlobal
      emptyValue="$(__mockEnvironmentEmpty "$argument")"
      saveGlobal="$(__mockEnvironmentGlobal "$argument")"
      # shellcheck disable=SC2163
      export "$argument"
      if [ "${!saveGlobal-"$emptyValue"}" = "$emptyValue" ]; then
        unset "$argument"
        statusMessage --last decorate notice "MOCK: Removing $argument (was unset)"
      else
        local value="${!saveGlobal-}"
        export "$argument"="$value"
        statusMessage --last decorate notice "MOCK: Restoring $argument ($(pluralWord "${#value}" character))"
      fi
      unset "$saveGlobal"
      ;;
    esac
    shift
  done
}

__mockConsoleAnimationStart() {
  local handler="$1" && shift

  local flag && flag=$(validate "$handler" Boolean "flag" "${1-}") || return $?
  __mockEnvironmentStart "$handler" CI || return $?
  export CI && CI="$(booleanChoose "$flag" "" "testCI")"
}

__mockConsoleAnimationStop() {
  local handler="$1" && shift
  __mockEnvironmentStop "$@" CI || return $?
}
