#!/usr/bin/env bash
#
# Documentation
#
# Copyright &copy; 2025 Market Acumen, Inc.

#
# Utility to export multi-line values as Bash variables
#
# Usage: __dumpNameValue name [ value0 value1 ... ]
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValue() {
  __dumpNameValuePrefix "" "$@"
}

__dumpSimpleValue() {
  local handler="returnMessage"
  local name="${1-}"
  case "${name:0:1}" in [[:alpha:]_]) ;; *) throwArgument "$handler" "Invalid variable name $name $(debuggingStack)" || return $? ;; esac
  printf -- "export %s\n" "$(catchReturn "$handler" environmentValueWrite "$name" "$(trimSpace "${2-}")")" || return $?
}

__dumpArrayValue() {
  local handler="returnMessage"
  local name="${1-}"
  case "${name:0:1}" in [[:alpha:]_]) ;; *) throwArgument "$handler" "Invalid variable name $name $(debuggingStack)" || return $? ;; esac
  printf "export %s\n" "$(environmentValueWriteArray "$@")"
}

#
# Export value appending existing value
#
# Usage: __dumpNameValueAppend name [ value0 value1 ... ]
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValueAppend() {
  local varName="$1"
  shift
  __dumpNameValuePrefixLocal "" "APPEND_$varName" "$@"
  # shellcheck disable=SC2016
  printf -- '%s="${%s}${APPEND_%s}"; unset APPEND_%s;\n' "$varName" "$varName" "$varName" "$varName"
}

#
# Usage: __dumpNameValuePrefix prefix name [ value0 value1 ... ]
# Argument: `prefix` - Literal string value to prefix each text line with
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValuePrefixLocal() {
  local handler="returnMessage"
  local prefix="${1}" name="${2}"
  case "${name:0:1}" in [[:alpha:]_]) ;; *) throwArgument "$handler" "Invalid variable name $name $(debuggingStack)" || return $? ;; esac
  printf -- "IFS='' read -r -d '' '%s' <<'%s' || :\n" "$name" "EOF" # Single quote means no interpolation
  shift 2
  while [ $# -gt 0 ]; do
    printf -- "%s%s\n" "$prefix" "$1"
    shift
  done
  printf -- "%s\n" "EOF"
}

#
# Usage: __dumpNameValuePrefix prefix name [ value0 value1 ... ]
# Argument: `prefix` - Literal string value to prefix each text line with
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValuePrefix() {
  local varName="${2}"
  printf -- "export '%s'; " "$varName"
  __dumpNameValuePrefixLocal "$@"
}

# This basically just does `a=${b}` in the output
#
# Summary: Assign one value to another in bash
# Usage: __dumpAliasedValue variable alias
# Argument: `variable` - shell variable to set
# Argument: `alias` - The shell variable to assign to `variable`
#
__dumpAliasedValue() {
  # SC2016 -- expressions do not expand in single quotes, yes, we know
  # shellcheck disable=SC2016
  printf -- 'export "%s"="%s%s%s"\n' "$1" '${' "$2" '}'
}
