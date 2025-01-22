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
mapEnvironment2() {
  local usage="_${FUNCNAME[0]}"

  local __prefix='{' __suffix='}' __ee=() __searchFilters=() __replaceFilters=()

  # IDENTICAL argument-case-header 5
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument="$1" argumentIndex=$((nArguments - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank #$argumentIndex/$nArguments: $(decorate each code "${saved[@]}")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$argumentIndex/$nArguments: $argument $(decorate each code "${saved[@]}")" || return $?
  done

  # If no environment variables are passed on the command line, then use all of them
  local __e
  if [ "${#__e[@]}" -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi

  (
    local __filter __value
    __value="$(__usageEnvironment "$usage" cat)" || return $?
    if [ $((${#__replaceFilters[@]} + ${#__searchFilters[@]})) -gt 0 ]; then
      for __e in "${__ee[@]}"; do
        local __search="$__prefix$__e$__suffix" __replace="${!__e-}"
        if [ ${#__searchFilters[@]} -gt 0 ]; then
          for __filter in "${__searchFilters[@]}"; do
            __search=$(__usageEnvironment "$usage" "$__filter" "$__search") || return $?
          done
        fi
        if [ ${#__replaceFilters[@]} -gt 0 ]; then
          for __filter in "${__replace[@]}"; do
            __replace=$(__usageEnvironment "$usage" "$__filter" "$__replace") || return $?
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
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL mapEnvironment EOF

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: {fn} [ environmentName ... ]
# TODO: Do this like `mapValue`
# See: mapValue
# Argument: environmentName - Optional. String. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - Optional. String. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - Optional. String. Suffix character for tokens, defaults to `}`.
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
mapEnvironment() {
  local usage="_${FUNCNAME[0]}"
  local __arg __sedFile __prefix='{' __suffix='}'

  while [ $# -gt 0 ]; do
    __arg="$1"
    [ -n "$__arg" ] || _argument "blank argument" || return $?
    case "$__arg" in
      --prefix)
        shift
        [ -n "${1-}" ] || _argument "blank $__arg argument" || return $?
        __prefix="$1"
        ;;
      --suffix)
        shift
        [ -n "${1-}" ] || _argument "blank $__arg argument" || return $?
        __suffix="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || _argument "shift failed after $__arg" || return $?
  done

  local __ee=("$@") __e
  if [ $# -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi
  __sedFile=$(__environment mktemp) || return $?
  if __environment _mapEnvironmentGenerateSedFile "$__prefix" "$__suffix" "${__ee[@]}" >"$__sedFile"; then
    if ! sed -f "$__sedFile"; then
      _environment "sed failed" || ! cat "$__sedFile" 1>&2 || ! rm -f "$__sedFile" || return $?
    fi
  fi
  rm -f "$__sedFile" || :
}
_mapEnvironment() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Helper function
_mapEnvironmentGenerateSedFile() {
  local __prefix="${1-}" __suffix="${2-}"

  shift 2
  while [ $# -gt 0 ]; do
    case "$1" in
      *[%{}]* | LD_*) ;; # skips
      *)
        printf "s/%s/%s/g\n" "$(quoteSedPattern "$__prefix$1$__suffix")" "$(quoteSedReplacement "${!1-}")"
        ;;
    esac
    shift
  done
}
