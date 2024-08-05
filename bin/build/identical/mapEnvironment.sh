#!/bin/bash
#
# Identical template
#
# Original of mapEnvironment
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# requires IDENTICAL _return
# requires IDENTICAL _sugar
#

# IDENTICAL mapEnvironment EOF

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: {fn} [ environmentName0 environmentName1 ... ]
# TODO: Do this like mapValue
# See: mapValue
# Argument: environmentName0 - Map this value only. If not specified, all environment variables are mapped.
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
mapEnvironment() {
  local this argument
  local prefix suffix sedFile ee e rs

  this="${FUNCNAME[0]}"
  prefix='{'
  suffix='}'

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || _argument "blank argument" || return $?
    case "$argument" in
      --prefix)
        shift
        [ -n "${1-}" ] || _argument "$this: blank $argument argument" || return $?
        prefix="$1"
        ;;
      --suffix)
        shift
        [ -n "${1-}" ] || _argument "$this: blank $argument argument" || return $?
        suffix="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || _argument "shift failed after $argument" || return $?
  done

  ee=("$@")
  if [ $# -eq 0 ]; then
    while read -r e; do ee+=("$e"); done < <(environmentVariables)
    for e in $(environmentVariables); do ee+=("$e"); done
  fi
  sedFile=$(mktemp) || _environment "mktemp failed" || return $?
  rs=0
  if __environment _mapEnvironmentGenerateSedFile "$prefix" "$suffix" "${ee[@]}" >"$sedFile"; then
    if ! sed -f "$sedFile"; then
      rs=$?
      cat "$sedFile" 1>&2
    fi
  else
    rs=$?
  fi
  rm -f "$sedFile" || :
  return $rs
}

# Helper function
_mapEnvironmentGenerateSedFile() {
  local i prefix="${1-}" suffix="${2-}"

  shift 2
  for i in "$@"; do
    case "$i" in
      *[%{}]* | LD_*) ;; # skips
      *)
        __environment printf "s/%s/%s/g\n" "$(quoteSedPattern "$prefix$i$suffix")" "$(quoteSedPattern "${!i-}")" || return $?
        ;;
    esac
  done
}
