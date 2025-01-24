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
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL _return 25
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf
_return() {
  local r="${1-:1}" && shift
  isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf -- "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# IDENTICAL _sugar 164

# Usage: {fn} [ separator [ prefix [ suffix [ title [ item ... ] ] ] ]
# Formats a titled list as {title}{separator}{prefix}{item}{suffix}{prefix}{item}{suffix}...
# Argument: separator - Optional. String.
# Argument: prefix - Optional. String.
# Argument: suffix - Optional. String.
# Argument: title - Optional. String.
# Argument: item - Optional. String. One or more items to list.
# Requires: printf
_format() {
  local sep="${1-}" prefix="${2-}" suffix="${3-}" title="${4-"§"}" n=/dev/null
  sep="${sep//%/%%}" && prefix="${prefix//%/%%}" && suffix="${suffix//%/%%}"
  # shellcheck disable=SC2015
  shift 2>"$n" && shift 2>"$n" && shift 2>"$n" && shift 2>"$n" || :
  if [ $# -eq 0 ]; then
    printf -- "%s\n" "$title"
  else
    printf -- "%s$sep%s\n" "$title" "$(printf -- "$prefix%s$suffix" "$@")"
  fi
}

# Output a titled list
# Usage: {fn} title [ items ... ]
# Requires: _format
_list() {
  _format "\n" "- " "\n" "$@"
}

# Output a command, quoting individual arguments
# Usage: {fn} command [ argument ... ]
# Requires: _format
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
# Requires: usageDocument printf
_code() {
  local k && while [ $# -gt 0 ]; do
    case "$1" in
      --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;;
      environment) k=1 ;; argument) k=2 ;; assert) k=97 ;; identical) k=105 ;; leak) k=108 ;; test) k=116 ;; exit) k=120 ;; internal) k=253 ;; *) k=254 ;;
    esac && shift && printf -- "%d\n" "$k"
  done
}

# Boolean test
# Returns 0 if `value` is boolean `false` or `true`.
# Usage: {fn} value
# Is this a boolean? (`true` or `false`)
# Exit Code: 0 - if value is a boolean
# Exit Code: 1 - if value is not a boolean
# Requires: usageDocument printf
isBoolean() {
  case "${1-}" in true | false) ;; *) return 1 ;; esac
}

# Boolean selector
# Usage: {fn} testValue trueChoice falseChoice
# Requires: isBoolean _argument printf
_choose() {
  local testValue="${1-}" && shift
  isBoolean "$testValue" || _argument "${BASH_SOURCE[1]-no function name}:${BASH_LINENO[0]-no line} ${FUNCNAME[1]} -> ${FUNCNAME[0]} non-boolean: \"$testValue\"" || return $?
  "$testValue" && printf -- "%s\n" "${1-}" || printf -- "%s\n" "${2-}"
}

# Usage: {fn} exitCode item ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: isUnsignedInteger _argument __environment
_clean() {
  local exitCode="${1-}" && shift
  isUnsignedInteger "$exitCode" || _argument "${FUNCNAME[0]} $exitCode (not an integer) $*" || return $?
  while [ $# -gt 0 ]; do
    [ ! -f "$1" ] || __environment rm "$1" || return $?
    [ ! -d "$1" ] || __environment rm -rf "$1" || return $?
    shift
  done
  return "$exitCode"
}

# Return `environment` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
# Requires: _return
_environment() {
  _return 1 "$@" || return $?
}

# Return `argument` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_return` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Requires: _return _command
__execute() {
  "$@" || _return $? "$(_command "$@")" || return $?
}

# Output the `command ...` to stdout prior to running, then `__execute` it
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: Any
# Requires: printf _command __execute
__echo() {
  printf -- "➡️ %s\n" "$(_command "$@")" && __execute "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_environment` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
# Requires: _environment
__environment() {
  "$@" || _environment "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_argument` if it fails.
# Usage: {fn} command ...FUNCNAME
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 2 - Failed
# Requires: _argument
__argument() {
  "$@" || _argument "$@" || return $?
}

# IDENTICAL quoteSedPattern 29

# Summary: Quote sed search strings for shell use
# Quote a string to be used in a sed pattern on the command line.
# Usage: quoteSedPattern text
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
# needSlash='$.*/[\]^'
# Requires: printf sed
quoteSedPattern() {
  local value
  value=$(printf -- "%s\n" "${1-}" | sed 's~\([][$/'$'\t''^\\.*+?]\)~\\\1~g')
  value="${value//$'\n'/\\n}"
  printf -- "%s\n" "$value"
}

# Summary: Quote sed replacement strings for shell use
# Usage: quoteSedReplacement text separatorChar
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"
# needSlash='$.*/[\]^'
# Requires: printf sed
quoteSedReplacement() {
  local value separator="${2-/}"
  value=$(printf -- "%s\n" "${1-}" | sed 's~\([\&'"$separator"']\)~\\\1~g')
  value="${value//$'\n'/\\n}"
  printf -- "%s\n" "$value"
}

# IDENTICAL environmentVariables 11

#
# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Requires: declare grep cut
environmentVariables() {
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}

# IDENTICAL usageDocumentSimple 18

# Output a simple error message for a function
# Requires: bashFunctionComment
# Requires: decorate read printf
usageDocumentSimple() {
  local source="${1-}" functionName="${2-}" exitCode="${3-}" color icon="❌" line prefix && shift 3

  case "$exitCode" in 0) icon="🏆" color=info ;; 1) color="error" ;; 2) color="bold-red" ;; *) color="orange" ;; esac
  printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$exitCode")" "$(decorate "$color" "$*")"
  while read -r line; do
    printf "%s%s\n" "$prefix" "$(decorate color "$line")"
    prefix=""
  done < <(bashFunctionComment "$source" "$functionName")
  return "$exitCode"
}
usageDocument() {
  usageDocumentSimple "$@"
}

# IDENTICAL bashFunctionComment 12
# Extract a bash comment from a file
# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# Notes: Keep this free of any extraneous dependencies
# Requires: grep cut reverseFileLines
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  grep -m 1 -B $maxLines "$functionName() {" "$source" | grep -v -e '( IDENTICAL |_IDENTICAL_|DOC TEMPLATE)' |
    reverseFileLines | grep -B "$maxLines" -m 1 -E '^\s*$' |
    reverseFileLines | grep -E '^#' | cut -c 3-
}

# IDENTICAL reverseFileLines 12

# Reverses a pipe's input lines to output using an awk trick.
#
# Not recommended on big files.
#
# Summary: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
# Requires: awk
reverseFileLines() {
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}

# IDENTICAL mapEnvironment 68

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
# Requires: _argument read environmentVariables __environment sed _environment cat rm
mapEnvironment() {
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

# fn: {base}
# Usage: {fn}
# See `mapEnvironment` for arguments and usage.
# See: mapEnvironment
__binMapEnvironment() {
  mapEnvironment "$@"
}

__binMapEnvironment "$@"
