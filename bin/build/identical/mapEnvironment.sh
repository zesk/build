#!/bin/bash
#
# Identical template
#
# Original of mapEnvironment (uses bash replace instead of sed)
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# requires a lot of stuff
#

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
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: __throwArgument read environmentVariables decorate sed cat rm __throwEnvironment __catchEnvironment _clean
# Requires: usageArgumentString
mapEnvironment() {
  local usage="_${FUNCNAME[0]}"
  local __sedFile __prefix='{' __suffix='}'

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --prefix)
      shift
      __prefix="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ;;
    --suffix)
      shift
      __suffix="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ;;
    *)
      break
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local __ee=("$@") __e __usage="$usage"
  unset usage

  if [ $# -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi
  __sedFile=$(__catchEnvironment "$__usage" mktemp) || return $?
  __catchEnvironment "$__usage" _mapEnvironmentGenerateSedFile "$__prefix" "$__suffix" "${__ee[@]}" >"$__sedFile" || returnClean $? "$__sedFile" || return $?
  __catchEnvironment "$__usage" sed -f "$__sedFile" || __throwEnvironment "$__usage" "$(cat "$__sedFile")" || returnClean $? "$__sedFile" || return $?
  __catchEnvironment "$__usage" rm -rf "$__sedFile" || return $?
}
_mapEnvironment() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Helper function
# Requires: printf quoteSedPattern quoteSedReplacement
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
