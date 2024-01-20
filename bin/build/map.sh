#!/usr/bin/env bash
#
# Map environment to values in a target file
#
# Usage: map.sh [ --prefix prefixString ] [ --suffix suffixString ] [ env0 ... ]
#
# Map environment variables and convert input file tokens to values of environment variables.
#
# Renamed to `map.sh` in 2023 to keep it short and sweet.
#
# Argument: --prefix prefixString - Optional. The prefix string to determine what a token is. Defaults to `{`. Must be before any environment variable names, if any.
# Argument: --suffix suffixString - Optional. The suffix string to determine what a token is. Defaults to `}`. Must be before any environment variable names, if any.
# Argument: env0 - Optional. If specified, then ONLY these environment variables are mapped; all others are ignored. If not specified, then all environment variables are mapped.
# Argument: ... - Optional. Additional environment variables to map can be specified as additional arguments
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
errorArgument=1

set -eou pipefail

quoteSedPattern() {
  # IDENTICAL quoteSedPattern 6
  value=$(printf %s "$1" | sed 's/\([.*+?]\)/\\\1/g')
  value="${value//\//\\/}"
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//$'\n'/\\n}"
  printf %s "$value"
}

#
# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Usage: {fn}
#
environmentVariables() {
  # IDENTICAL environmentVariables 1
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}

_mapEnvironmentGenerateSedFile() {
  # IDENTICAL _mapEnvironmentGenerateSedFile 12
  local sedFile=$1 value

  shift
  for i in "$@"; do
    case "$i" in
      *[%{}]*) ;;
      LD_*) ;;
      *)
        printf "s/%s/%s/g\n" "$(quoteSedPattern "$prefix$i$suffix")" "$(quoteSedPattern "${!i-}")" >>"$sedFile"
        ;;
    esac
  done
}

#
# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: map.sh [ environmentName0 environmentName1 ... ]
# Usage: mapEnvironment [ environmentName0 environmentName1 ... ]
# fn: map.sh
# TODO: Do this like mapValue
# See: mapValue
# Argument: environmentName0 - Map this value only. If not specified, all environment variables are mapped.
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world map.sh NAME PLACE
#
mapEnvironment() {
  # IDENTICAL mapEnvironment 79 120
  local prefix suffix sedFile ee e rs

  prefix='{'
  suffix='}'

  while [ $# -gt 0 ]; do
    case $1 in
      --prefix)
        shift || usage $errorArgument "--prefix missing a value"
        prefix="$1"
        ;;
      --suffix)
        shift || usage $errorArgument "--suffix missing a value"
        suffix="$1"
        ;;
      *)
        break
        ;;
    esac
    shift
  done

  sedFile=$(mktemp)

  if [ $# -eq 0 ]; then
    ee=()
    for e in $(environmentVariables); do
      ee+=("$e")
    done
    _mapEnvironmentGenerateSedFile "$sedFile" "${ee[@]}"
  else
    _mapEnvironmentGenerateSedFile "$sedFile" "$@"
  fi

  if ! sed -f "$sedFile"; then
    rs=$?
    cat "$sedFile" 1>&2
    rm "$sedFile"
    return $rs
  fi
  rm "$sedFile"
}

mapEnvironment "$@"
