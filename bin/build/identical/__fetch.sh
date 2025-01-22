#!/bin/bash
#
# Original of realPath
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# wget notes
#
# Auth
# --http-user=user
# --http-password=password
#
# Sessions
# --save-cookies file
# --load-cookies file
# Bugs
# --ignore-length (ignores incorrect length)
#
# Security-stuff:
# --certificate=file
# --certificate-type=type
# --private-key=file
# --private-key-type=type

# IDENTICAL __fetch EOF
# Usage: {fn} usage { --header header ] url
# Argument: url - Required. URL. URL to fetch to stdout
__fetch() {
  local usage="$1" && shift

  local wgetArgs=() curlArgs=() headers

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument="$1" argumentIndex=$((nArguments - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "Argument #$argumentIndex is blank" || return $?
    case "$argument" in
      --header)
        shift
        local name value
        name="${1%%:}"
        value="${1#*:}"
        if [ "$name" = "$1" ] || [ "$value" = "$1" ]; then
          __usageArgument "$usage" "Invalid $argument $1 passed" || return $?
        fi
        headers+=("$1")
        curlArgs+=("--header" "$1")
        wgetArgs+=("--header=$1")
        ;;
      --agent)
        shift
        local agent="$1"
        [ -n "$agent" ] || __failArgument "$usage" "$argument must be non-blank" || return $?
        wgetArgs+=("--user-agent=$1")
        curlArgs+=("--user-agent" "$1")
        ;;
      *)
        if [ -z "$url" ]; then
          url="$1"
        elif [ -z "$target" ]; then
          target="$1"
          shift
          break
        else
          __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  if whichExists wget; then
    wget --no-verbose --output-document="$target" --timeout=10 "${wgetArgs[@]+"${wgetArgs[@]}"}"
  elif whichExists curl; then
    curl -L -s "$url" "$@" -o "$target" "${curlArgs[@]+"${curlArgs[@]}"}"
  else
    __usageEnvironment "$usage" "wget or curl required, please install one" || return $?
  fi
}
