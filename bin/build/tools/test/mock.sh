#!/usr/bin/env bash
#
# mock.sh
#
# Fake conditions to test them
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Fake a value for testing
# Argument: globalName - EnvironmentVariable. Required. Global to change temporarily to a value.
# Argument: value - EmptyString. Optional. Force the value of `globalName` to this value temporarily. Saves the original value.
# Argument: ... - Continue passing pairs of globalName value to mock additional values.
mockEnvironmentStart() {
  local handler="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    local argument="${1-}" && shift
    local emptyValue="__MOCK__ $argument"
    local value="${1-}"
    [ $# -eq 0 ] || shift
    local saveGlobal="__MOCK_$argument"
    statusMessage decorate notice "MOCK: Saving $argument into $(decorate code "$saveGlobal")"
    # shellcheck disable=SC2163
    export "$saveGlobal"="${!argument-"$me"}"
    export "$argument"="$value"
  done
}
_mockEnvironmentStart() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Restore a mocked value. Works solely with the default `saveGlobalName` (e.g. `__MOCK_${globalName}`).
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value.
mockEnvironmentStop() {
  local handler="_${FUNCNAME[0]}"
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local emptyValue="__MOCK__ $argument"
      # shellcheck disable=SC2163
      export "$argument"
      if [ "${!argument-"$emptyValue"}" = "$emptyValue" ]; then
        unset "$argument"
        statusMessage decorate notice "MOCK: Removing $argument (was unset)"
      else
        local saveGlobal="__MOCK_$argument"
        export "$argument"="${!saveGlobal-}"
        statusMessage decorate notice "MOCK: Restoring $argument from $(decorate code "$saveGlobal")"
      fi
      unset "$saveGlobal"
      ;;
    esac
    shift
  done
}

# Fake `hasConsoleAnimation` for testing
# Argument: true | false - Boolean. Force the value of hasConsoleAnimation to this value temporarily. Saves the original value.
# Developer Note: Keep this here to keep it close to the definition it modifies
mockConsoleAnimationStart() {
  local handler="_${FUNCNAME[0]}"

  flag=$(usageArgumentBoolean "$handler" "flag" "${1-}") || return $?
  mockEnvironmentStart CI "$(_choose "$flag" "" "testCI")" "$@"
}
_mockConsoleAnimationStart() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Stop faking `hasConsoleAnimation` for testing
mockConsoleAnimationStop() {
  local handler="_${FUNCNAME[0]}" flag="${1-}"

  mockEnvironmentStop CI
}
_mockConsoleAnimationStop() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
