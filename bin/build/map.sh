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

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# IDENTICAL _sugar 139

# Usage: {fn} [ separator [ prefix [ suffix [ title [ item ... ] ] ] ]
# Formats a titled list as {title}{separator}{prefix}{item}{suffix}{prefix}{item}{suffix}...
# Argument: separator - Optional. String.
# Argument: prefix - Optional. String.
# Argument: suffix - Optional. String.
# Argument: title - Optional. String.
# Argument: item - Optional. String. One or more items to list.
_format() {
  local sep="${1-}" prefix="${2-}" suffix="${3-}" title="${4-"§"}"
  sep="${sep//%/%%}" && prefix="${prefix//%/%%}" && suffix="${suffix//%/%%}"
  shift && shift && shift && shift
  printf -- "%s$sep%s\n" "$title" "$(printf -- "$prefix%s$suffix" "$@")"
}

# Output a titled list
# Usage: {fn} title [ items ... ]
_list() {
  _format "\n" "- " "\n" "$@"
}

# Output a command, quoting individual arguments
# Usage: {fn} command [ argument ... ]
_command() {
  _format "" " \"" "\"" "$@"
}

# Usage: {fn} name ...
# Argument: name ... - Optional. String. Exit code value to output.
# Print one or more an exit codes by name.
#
# Valid codes:
#
# - `environment` - generic issue with environment
# - `argument` - issue with arguments
# - `assert` - assertion failed
# - `identical` - identical check failed
# - `leak` - function leaked globals
# - `test` - test failed
# - `exit` - exit function immediately
# - `internal` - internal errors
#
# Unknown error code is 254, end of range is 255 which is not used.
#
# ### Error codes reference (`_code`):
#
# - 1 - environment or general error
# - 2 - argument error
# - 97 - assert - ASCII 97 = `a`
# - 105 - identical - ASCII 105 = `i`
# - 108 - leak - ASCII 108 = `l`
# - 116 - test - ASCII 116 = `t`
# - 120 - exit - ASCII 120 = `x`
# - 253 - internal
# - 254 - unknown
#
# See: https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux
_code() {
  local k && while [ $# -gt 0 ]; do
    case "$(printf "%s" "$1" | tr '[:upper:]' '[:lower:]')" in
      environment) k=1 ;; argument) k=2 ;; assert) k=97 ;; identical) k=105 ;; leak) k=108 ;; test) k=116 ;; exit) k=120 ;; internal) k=253 ;; *) k=254 ;;
    esac && shift && printf "%d\n" "$k"
  done
}

# Boolean test
# Returns 0 if `value` is boolean `false` or `true`.
# Usage: {fn} value
# Is this a boolean? (`true` or `false`)
# Exit Code: 0 - if value is a boolean
# Exit Code: 1 - if value is not a boolean
_boolean() {
  case "${1-}" in true | false) ;; *) return 1 ;; esac
}

# Boolean selector
# Usage: {fn} testValue trueChoice falseChoice
_choose() {
  local testValue="${1-}" && shift
  _boolean "$testValue" || _argument "${FUNCNAME[1]-no function name}:${BASH_LINENO[1]-no line} -> ${FUNCNAME[0]} _choose non-boolean: \"$testValue\"" || return $?
  "$testValue" && printf "%s\n" "${1-}" || printf "%s\n" "${2-}"
}

# Return `environment` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# Return `argument` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_return` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
__execute() {
  "$@" || _return $? "$(_command "$@")" || return $?
}

# Run `command ...` (with any arguments) and then `exit` if it fails. Critical code only.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: None
__try() {
  __execute "$@" || _return $? "💣 $(_command "$@")" || exit $?
}

# Output the `command ...` to stdout prior to running, then `__execute` it
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: Any
__echo() {
  printf "➡️ %s\n" "$(_command "$@")" && __execute "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_environment` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
__environment() {
  "$@" || _environment "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_argument` if it fails.
# Usage: {fn} command ...FUNCNAME
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 2 - Failed
__argument() {
  "$@" || _argument "$@" || return $?
}

# IDENTICAL quoteSedPattern 17

# Summary: Quote sed strings for shell use
# Quote a string to be used in a sed pattern on the command line.
# Usage: quoteSedPattern text
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
#
quoteSedPattern() {
  value=$(printf "%s\n" "$1" | sed 's/\([\\.*+?]\)/\\\1/g')
  value="${value//\//\\/}"
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//&/\\&}"
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}

# IDENTICAL environmentVariables 12

#
# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Usage: {fn}
#
environmentVariables() {
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}

# IDENTICAL mapEnvironment 71

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
        __environment printf "s/%s/%s/g\n" "$(quoteSedPattern "$__prefix$1$__suffix")" "$(quoteSedPattern "${!1-}")" || return $?
        ;;
    esac
    shift
  done
}

# fn: {base}
# Usage: {fn}
# See `mapEnvironment` for arguments and usage.
# See: mapEnvironment
__binMapEnvironment() {
  mapEnvironment "$@"
}

__binMapEnvironment "$@"
