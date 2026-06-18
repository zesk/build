#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of mapEnvironment
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL mapEnvironment EOF

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# This one does it like `mapValue`
# Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination.
# See: mapValue
# Argument: environmentVariableName - String. Optional. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: environmentVariables cat throwEnvironment catchEnvironment
# Requires: throwArgument decorate validate
# shellcheck disable=SC2120
mapEnvironment() {
  local handler="_${FUNCNAME[0]}"

  local __prefix='{' __suffix='}' __ee=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix) shift && __prefix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --suffix) shift && __suffix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --env-file) shift && muzzle validate "$handler" LoadEnvironmentFile "$argument" "${1-}" || return $? ;;
    *) __ee+=("$(validate "$handler" String "environmentVariableName" "$argument")") || return $? ;;
    esac
    shift
  done

  # If no environment variables are passed on the command line, then use all of them
  local __e
  if [ "${#__ee[@]}" -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi

  (
    local __value && __value="$(catchEnvironment "$handler" cat)" || return $?
    unset handler
    for __e in "${__ee[@]}"; do
      case "${__e}" in *[!A-Za-z0-9_]*) continue ;; *) ;; esac
      local __search="$__prefix$__e$__suffix"
      local __replace="${!__e-}"
      __value="${__value//"$__search"/$__replace}"
    done
    printf "%s" "$__value"
  )
}
_mapEnvironment() {
  decorateInitialized || decorate info --
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
