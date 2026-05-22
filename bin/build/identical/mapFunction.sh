#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of mapFunction
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL mapFunction EOF

# Summary: Convert tokens in input to values
#
# Map tokens in the input stream based on some heuristic.
#
# Converts tokens in the form `{VARIABLE}` to the associated value.
#
# Undefined values are not converted.
#
# See: mapValue mapEnvironment
# Argument: --env-file envFile - File. Optional. Load this environment file prior to processing input.
# Argument: --default defaultString - String. Optional. Default string for tokens. Can use additional tokens: `{prefix}` `{suffix}` `{tokenName}` and `{token}`. Set to `--` to output `token`.
# Argument: --prefix prefixString - String. Optional. Prefix character for tokens, defaults to `{`.
# Argument: --suffix suffixString - String. Optional. Suffix character for tokens, defaults to `}`.
# Argument:  mapFunction ... - Function. Required. Replacement function with arguments. Called as is with three additional arguments: `tokenName` `offset` `total`
#
# `mapFunction` should return non-zero to have the default behavior occur. If a zero exit code is output then some replacement value is assumed to be written to `stdout` by the `mapFunction`.
# The special return code 120 is used to terminate the calling function immediately.
# Return Code: 120 - Map function exited early
# Return Code: 130 - User interrupt (exits early)
# Return Code: 141 - System interrupt (exits early)
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Requires: cat throwEnvironment catchEnvironment
# Requires: throwArgument decorate validate
mapFunction() {
  local handler="_${FUNCNAME[0]}"

  local __prefix='{' __suffix='}' __ee=() __searchFilters=() __replaceFilters=() mapper=() __default="--"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --default) shift && __default=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    --prefix) shift && __prefix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --suffix) shift && __suffix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --env-file) shift && muzzle validate "$handler" LoadEnvironmentFile "$argument" "${1-}" || return $? ;;
    *) muzzle validate "$handler" Function "mapFunction" "$1" && mapper=("$@") && set -- && break || return $? ;;
    esac
    shift
  done

  [ ${#mapper[@]} -gt 0 ] || throwArgument "$handler" "mapFunction is required" || return $?

  local __counter=0 __checkValue=""
  local __failed=()
  local __value && __value="$(catchEnvironment "$handler" cat)" || return $?
  local __offset=0 __total="${#__value}" && while true; do
    local __remain="${__value#*"$__prefix"}"
    [ "$__remain" != "$__value" ] || break
    local __tokenName="${__remain%%"$__suffix"*}"
    [ "$__tokenName" != "$__remain" ] || break
    local __before="${__value%%"$__prefix"*}"
    __offset=$((__offset + ${#__before}))
    printf -- "%s" "$__before"
    __value="${__value#*"$__suffix"}"
    if [ "${__tokenName#*$'\n'}" != "$__tokenName" ]; then
      # Invalid token name (newline)
      printf -- "%s%s%s" "$__prefix" "$__tokenName" "$__suffix"
      continue
    else
      local __token="$__prefix$__tokenName$__suffix"
      local __returnCode && if [ "${#__failed[@]}" -gt 0 ] && inArray "$__tokenName" "${__failed[@]}"; then
        __returnCode=1
      else
        if "${mapper[@]}" "$__tokenName" "$__offset" "$__total"; then
          __returnCode=0
        else
          __returnCode=$?
          __failed+=("$__tokenName")
        fi
      fi
      case "$__returnCode" in 120 | 130 | 141) return "$__returnCode" ;; esac
      [ "$__returnCode" -gt 0 ] || continue
      case "$__default" in
      "") ;;
      --) printf -- "%s" "$__token" ;;
      *) printf -- "%s" "$(prefix="$__prefix" suffix="$__suffix" tokenName="$__tokenName" token="$__prefix$__tokenName$__suffix" mapEnvironment <<<"$__default")" ;;
      esac
    fi
    __counter=$((__counter + 1))
    if [ $__counter -gt 1000 ]; then
      throwEnvironment "$handler" "Infinite loop found at $__count $__offset of $__total $(dumpPipe "Infinite loop found at $__count $__offset of $__total Remain:" <<<"$__value")" || return $?
    fi
  done
  printf -- "%s" "$__value"
}
_mapFunction() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
