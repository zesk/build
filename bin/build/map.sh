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
errorEnvironment=1
emptyArgument="§"

set -eou pipefail

# Return code always. Outputs `message ...` to `stderr`.
# Usage: {fn} code command || return $?
# Argument: code - Integer. Required. Return code.
# Argument: message ... - String. Optional. Message to output.
_return() {
  local code
  code="${1-1}" && shift && printf "%s failed (%d)\n" "${*-"$emptyArgument"}" "$code" 1>&2 && return "$code"
}

# Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return "$errorEnvironment" "$@" || return $?
}

# Return `$errorArgument` always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return "$errorArgument" "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_environment` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
__environment() {
  "$@" || _environment "$@" || return $?
}

# DO NOT EDIT THIS ONE
quoteSedPattern() {
  # IDENTICAL quoteSedPattern 6
  value=$(printf %s "$1" | sed 's/\([\\.*+?]\)/\\\1/g')
  value="${value//\//\\/}"
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//&/\&}"
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
  # IDENTICAL _mapEnvironmentGenerateSedFile 11
  local i

  for i in "$@"; do
    case "$i" in
      *[%{}]*) ;;
      LD_*) ;;
      *)
        printf "s/%s/%s/g\n" "$(quoteSedPattern "$prefix$i$suffix")" "$(quoteSedPattern "${!i-}")"
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
  # IDENTICAL mapEnvironment 94 137
  local this argument
  local prefix suffix sedFile ee e rs

  this="${FUNCNAME[0]}"
  prefix='{'
  suffix='}'

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || _argument "$this: Blank argument" || return $?
    case "$argument" in
      --prefix)
        shift || _argument "$this: missing $argument argument" || return $?
        prefix="$1"
        ;;
      --suffix)
        shift || _argument "$this: missing $argument argument" || return $?
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
  if __environment _mapEnvironmentGenerateSedFile "${ee[@]}" >"$sedFile"; then
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

mapEnvironment "$@"
