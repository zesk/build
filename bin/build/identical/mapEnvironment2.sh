#!/bin/bash
#
# Identical template
#
# Original of mapEnvironment
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# requires IDENTICAL _return
# requires IDENTICAL _sugar
# requires IDENTICAL _colors
#

# Do not put mapEnvironment2 into this file just yet

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: {fn} [ environmentName ... ]
# This one does it like `mapValue`
# See: mapValue
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: environmentVariableName - Optional. String. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - Optional. String. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - Optional. String. Suffix character for tokens, defaults to `}`.
# Argument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
# Argument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: __failArgument decorate
mapEnvironment2() {
  local usage="_${FUNCNAME[0]}"

  local __prefix='{' __suffix='}' __ee=() __searchFilters=() __replaceFilters=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --prefix)
        shift
        __prefix=$(usageArgumentString "$usage" "$argument" "${1-}")
        ;;
      --suffix)
        shift
        __suffix=$(usageArgumentString "$usage" "$argument" "${1-}")
        ;;
      --search-filter)
        shift
        __searchFilters+=("$(usageArgumentCallable "$usage" "searchFilter" "${1-}")") || return $?
        ;;
      --replace-filter)
        shift
        __replaceFilters+=("$(usageArgumentCallable "$usage" "replaceFilter" "${1-}")") || return $?
        ;;
      --env-file)
        shift
        muzzle usageArgumentLoadEnvironmentFile "$usage" "$argument" "${1-}" || return $?
        ;;
      *)
        __ee+=("$(usageArgumentEnvironmentValue "$usage" "environmentVariableName" "$argument")")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  # If no environment variables are passed on the command line, then use all of them
  local __e
  if [ "${#__e[@]}" -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi

  (
    local __filter __value __usage="$usage"
    unset usage

    __value="$(__usageEnvironment "$__usage" cat)" || return $?
    if [ $((${#__replaceFilters[@]} + ${#__searchFilters[@]})) -gt 0 ]; then
      for __e in "${__ee[@]}"; do
        local __search="$__prefix$__e$__suffix" __replace="${!__e-}"
        if [ ${#__searchFilters[@]} -gt 0 ]; then
          for __filter in "${__searchFilters[@]}"; do
            __search=$(__usageEnvironment "$__usage" "$__filter" "$__search") || return $?
          done
        fi
        if [ ${#__replaceFilters[@]} -gt 0 ]; then
          for __filter in "${__replace[@]}"; do
            __replace=$(__usageEnvironment "$__usage" "$__filter" "$__replace") || return $?
          done
        fi
        __value="${__value/$__search/$__replace}"
      done
    else
      for __e in "${__ee[@]}"; do
        local __search="$__prefix$__e$__suffix" __replace="${!__e-}"
        __value="${__value/$__search/$__replace}"
      done
    fi
    printf "%s\n" "$__value"
  )
}
_mapEnvironment2() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
