#!/usr/bin/env bash
#
# mock.sh
#
# Fake conditions to test them
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Fake a value for testing
# Usage: {fn} globalName [ saveGlobalName ] [ --end | value ]
# Argument: globalName - EnvironmentVariable. Required. Global to change temporarily to a value.
# Argument: saveGlobalName - EnvironmentVariable. Optional. Resets the `globalName` to the value in `saveGlobalName` if set.
# Argument: --end - Flag. Optional. Resets the `globalName` to the value in `saveGlobalName` if set.
# Argument: value - EmptyString. Required. Force the value of `globalName` to this value temporarily. Saves the original value in global `saveGlobalName`.
__mockValue() {
  local usage="_${FUNCNAME[0]}"
  local me="$usage ${1-} ${2-}" global="${1-}"
  local saveGlobal="${2:-"__MOCK_${global}"}" value="${3-}"
  [ $# -le 3 ] || IFS=';' __throwArgument "$usage" "$me requires no more than 3 arguments: [$#]: $*" || return $?
  if [ "$value" = "--end" ]; then
    # shellcheck disable=SC2163
    export "$saveGlobal"
    if [ "${!saveGlobal-"$me"}" = "$me" ]; then
      unset "$global"
    else
      export "$global"="${!saveGlobal-}"
    fi
    unset "$saveGlobal"
    return 0
  fi
  # shellcheck disable=SC2163
  export "$saveGlobal"="${!global-"$me"}"
  export "$global"="$value"
}
___mockValue() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
