#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of mapEnvironmentFun
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL mapEnvironmentFun EOF

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Uses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.
# See: mapEnvironment
# See: mapValue
# Argument: environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped.
# Argument: --env-file envFile - File. Optional. Load this environment file prior to processing input.
# Argument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: throwArgument decorate
# Requires: validate
mapEnvironmentFun() {
  local handler="_${FUNCNAME[0]}"
  local __aa=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file | --prefix | --suffix) shift && __aa+=("$("$argument" "${1-}")") ;;
    *) break ;;
    esac
    shift
  done

  local onlyList && onlyList=$(listJoin ":" "$@")
  [ -z "$onlyList" ] || onlyList=":$onlyList:"
  mapFunction "${__aa[@]+"${__aa[@]}"}" __mapEnvironmentFun "$onlyList"
}
_mapEnvironmentFun() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Helper function
__mapEnvironmentFun() {
  local __onlyList="$1" && shift
  local __tokenName="$1" && shift
  [ -z "$__onlyList" ] || stringContains "$__onlyList" ":$__tokenName:" || return 1
  [ -n "${!__tokenName+x}" ] || return 1
  printf -- %s "${!__tokenName}"
}
