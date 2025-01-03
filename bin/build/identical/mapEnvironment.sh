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

# IDENTICAL mapEnvironment EOF

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: {fn} [ environmentName ... ]
# TODO: Do this like mapValue
# See: mapValue
# Argument: environmentName - Optional. String. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - Optional. String. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - Optional. String. Suffix character for tokens, defaults to `}`.
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
mapEnvironment() {
  local __arg
  local __prefix __suffix __sedFile __ee __e

  __prefix='{'
  __suffix='}'

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

  __ee=("$@")
  if [ $# -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi
  __sedFile=$(__environment mktemp) || return $?
  if __environment _mapEnvironmentGenerateSedFile "$__prefix" "$__suffix" "${__ee[@]}" >"$__sedFile"; then
    if ! sed -f "$__sedFile"; then
      cat "$__sedFile" 1>&2
      _environment "sed failed" || return $?
    fi
  fi
  rm -f "$__sedFile" || :
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
