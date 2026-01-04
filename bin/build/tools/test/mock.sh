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

# Fake a value for testing
# Argument: globalName - EnvironmentVariable. Required. Global to change temporarily to a value.
# Argument: value - EmptyString. Optional. Force the value of `globalName` to this value temporarily. Saves the original value.
# Argument: ... - Continue passing pairs of globalName value to mock additional values.
mockEnvironmentStart() {
  local handler="_${FUNCNAME[0]}"
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
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
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

# Fake `hasConsoleAnimation` for testing
# Argument: true | false - Boolean. Force the value of hasConsoleAnimation to this value temporarily. Saves the original value.
# Developer Note: Keep this here to keep it close to the definition it modifies
mockConsoleAnimationStart() {
  local handler="_${FUNCNAME[0]}" flag

  flag=$(usageArgumentBoolean "$handler" "flag" "${1-}") || return $?
  catchReturn "$handler" mockEnvironmentStart CI || return $?
  export CI
  CI="$(booleanChoose "$flag" "" "testCI")"
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
