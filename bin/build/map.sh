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

# IDENTICAL _return 26

# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Required. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local r="${1-:1}" && shift 2>/dev/null
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

# IDENTICAL _tinySugar 73

# Run `handler` with an argument error
# Usage: {fn} handler ...
__throwArgument() {
  local handler="${1-}"
  shift && "$handler" 2 "$@" || return $?
}

# Run `handler` with an environment error
# Usage: {fn} handler ...
__throwEnvironment() {
  local handler="${1-}"
  shift && "$handler" 1 "$@" || return $?
}

# Run `command`, upon failure run `handler` with an argument error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __throwArgument
__catchArgument() {
  local handler="${1-}"
  shift && "$@" || __throwArgument "$handler" "$@" || return $?
}

# Run `command`, upon failure run `handler` with an environment error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __throwEnvironment
__catchEnvironment() {
  local handler="${1-}"
  shift && "$@" || __throwEnvironment "$handler" "$@" || return $?
}

# _IDENTICAL_ _errors 16

# Return `argument` error code always. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code always. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
# Requires: _return
_environment() {
  _return 1 "$@" || return $?
}

# _IDENTICAL_ __environment 10

# Run `command ...` (with any arguments) and then `_environment` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
# Requires: _environment
__environment() {
  "$@" || _environment "$@" || return $?
}

# Usage: {fn} exitCode item ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: rm
_clean() {
  local r="${1-}" && shift && rm -rf "$@"
  return "$r"
}

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

# IDENTICAL environmentVariables 10

# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Requires: declare grep cut
environmentVariables() {
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}

usageDocument() {
  usageDocumentSimple "$@"
}

# IDENTICAL usageDocumentSimple 15

# Output a simple error message for a function
# Requires: bashFunctionComment decorate read printf exitString
usageDocumentSimple() {
  local source="${1-}" functionName="${2-}" exitCode="${3-}" color helpColor="info" icon="❌" line prefix="" skip=false && shift 3

  case "$exitCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="bold-red" ;; *) color="orange" ;; esac
  [ $# -eq 0 ] || [ "$exitCode" -ne 0 ]
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(exitString "$exitCode")")" "$(decorate "$color" "$*")"
  while read -r line; do
    printf "%s%s\n" "$prefix" "$(decorate "$helpColor" "$line")"
    prefix=""
  done < <(bashFunctionComment "$source" "$functionName")
  return "$exitCode"
}

# IDENTICAL bashFunctionComment 18

# Extract a bash comment from a file
# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# Requires: grep cut reverseFileLines __help
# Requires: usageDocument
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  __help "_${FUNCNAME[0]}" "$@" || return 0
  grep -m 1 -B $maxLines "$functionName() {" "$source" | grep -v -e '( IDENTICAL | _IDENTICAL_ |DOC TEMPLATE:|Internal:)' |
    reverseFileLines | grep -B "$maxLines" -m 1 -E '^\s*$' |
    reverseFileLines | grep -E '^#' | cut -c 3-
}
_bashFunctionComment() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL __help 34

# Usage: {fn} [ --only ] usageFunction arguments
# Simple help argument handler.
#
# Easy `--help` handler for any function useful when it's the only option.
#
# Useful for utilities which single argument types, single arguments, and no arguments (except for `--help`)
#
# Oddly one of the few functions we can not offer the `--help` flag for.
#
# Argument: --only - Flag. Optional. Must be first parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: usageFunction - Function. Required. Must be first or second parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: arguments ... - Arguments. Optional. Arguments passed to calling function to check for `--help` argument.
# Example:     __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     __help "$usage" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
# Depends: __throwArgument
__help() {
  local usage="${1-}" && shift
  if [ "$usage" = "--only" ]; then
    usage="${1-}" && shift
    [ $# -gt 0 ] || return 0
    [ "$#" -eq 1 ] && [ "${1-}" = "--help" ] || __throwArgument "$usage" "Only argument allowed is --help: \"${1-}\"" || return $?
  fi
  while [ $# -gt 0 ]; do
    if [ "$1" = "--help" ]; then
      "$usage" 0
      return 1
    fi
    shift
  done
  return 0
}

# IDENTICAL _type 46

# Usage: {fn} argument ...
# Test if an argument is a positive integer (non-zero)
#
# Exit Code: 0 - if it is a positive integer
# Exit Code: 1 - if it is not a positive integer
# Requires: __catchArgument isUnsignedInteger usageDocument
isPositiveInteger() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || __catchArgument "$usage" "Single argument only: $*" || return $?
  if isUnsignedInteger "$1"; then
    [ "$1" -gt 0 ] || return 1
    return 0
  fi
  if [ "$1" = "--help" ]; then
    "$usage" 0
    return 0
  fi
  return 1
}
_isPositiveInteger() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Test if argument are bash functions
# Usage: {fn} string0
# Argument: string - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - argument is bash function
# Exit code: 1 - argument is not a bash function
# Requires: __catchArgument isUnsignedInteger usageDocument type
isFunction() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || __catchArgument "$usage" "Single argument only: $*" || return $?
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
_isFunction() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# _IDENTICAL_ exitString 6

# Output the exit code as a string
# Winner of the one-line bash award 10 years running
exitString() {
  local k="" && while [ $# -gt 0 ]; do case "$1" in 1) k="environment" ;; 2) k="argument" ;; 97) k="assert" ;; 105) k="identical" ;; 108) k="leak" ;; 116) k="timeout" ;; 120) k="exit" ;; 253) k="internal" ;; esac && [ -n "$k" ] || k="$1" && printf "%s\n" "$k" && shift; done
}

# IDENTICAL usageArgumentCore 14

# Require an argument to be non-blank
# Usage: {fn} usage argument [ value ]
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be non-blank otherwise an argument error is thrown.
# Exit Code: 2 - If `value` is blank
# Exit code: 0 - If `value` is non-blank
usageArgumentString() {
  local usage="$1" argument="$2"
  shift 2 || :
  [ -n "${1-}" ] || __throwArgument "$usage" "blank" "$argument" || return $?
  printf "%s\n" "$1"
}

# IDENTICAL decorate 182

# Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate
#
# Usage: hasColors
# Exit Code: 0 - Console or output supports colors
# Exit Code: 1 - Colors are likely not supported by console
# Environment: BUILD_COLORS - Optional. Boolean. Whether the build system will output ANSI colors.
# Requires: isPositiveInteger tput
hasColors() {
  local usage="_${FUNCNAME[0]}"
  local termColors
  export BUILD_COLORS TERM

  [ "${1-}" != "--help" ] || ! "$usage" 0 || return 0
  # Values allowed for this global are true and false
  # Important - must not use buildEnvironmentLoad BUILD_COLORS TERM; then
  BUILD_COLORS="${BUILD_COLORS-}"
  if [ -z "$BUILD_COLORS" ]; then
    BUILD_COLORS=false
    case "${TERM-}" in "" | "dumb" | "unknown") BUILD_COLORS=true ;; *)
      termColors="$(tput colors 2>/dev/null)"
      isPositiveInteger "$termColors" || termColors=2
      [ "$termColors" -lt 8 ] || BUILD_COLORS=true
      ;;
    esac
  elif [ "$BUILD_COLORS" = "1" ]; then
    # Backwards
    BUILD_COLORS=true
  elif [ -n "$BUILD_COLORS" ] && [ "$BUILD_COLORS" != "true" ]; then
    BUILD_COLORS=false
  fi
  [ "${BUILD_COLORS-}" = "true" ]
}
_hasColors() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  ! false || hasColors --help
}

#
# Semantics-based
#
# Usage: {fn} label lightStartCode darkStartCode endCode [ -n ] [ message ]
# Requires: hasColors printf
__decorate() {
  local prefix="$1" start="$2" dp="$3" end="$4" && shift 4
  export BUILD_COLORS_MODE BUILD_COLORS
  if [ -n "${BUILD_COLORS-}" ] && [ "${BUILD_COLORS-}" = "true" ] || [ -z "${BUILD_COLORS-}" ] && hasColors; then
    if [ "${BUILD_COLORS_MODE-}" = "dark" ]; then
      start="$dp"
    fi
    if [ $# -eq 0 ]; then printf -- "%s$start" ""; else printf -- "$start%s$end\n" "$*"; fi
    return 0
  fi
  [ $# -gt 0 ] || return 0
  if [ -n "$prefix" ]; then printf -- "%s: %s\n" "$prefix" "$*"; else printf -- "%s\n" "$*"; fi
}

# Output a list of build-in decoration styles, one per line
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
decorations() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" reset \
    underline no-underline bold no-bold \
    black black-contrast blue cyan green magenta orange red white yellow \
    bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow \
    code info notice success warning error subtle label value decoration
}
_decorations() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  ! false || decorations --help
}

# Singular decoration function
# Usage: decorate style [ text ... ]
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow code info notice success warning error subtle label value decoration
# Argument: text - Text to output. If not supplied, outputs a code to change the style to the new style.
# stdout: Decorated text
# Requires: isFunction _argument awk __catchEnvironment usageDocument
decorate() {
  local usage="_${FUNCNAME[0]}" text="" what="${1-}" lp dp style
  shift && [ -n "$what" ] || __catchArgument "$usage" "Requires at least one argument: \"$*\"" || return $?
  if ! style=$(_caseStyles "$what"); then
    local extend func="${what/-/_}"
    extend="__decorateExtension$(printf "%s" "${func:0:1}" | awk '{print toupper($0)}')${func:1}"
    # When this next line calls `__catchArgument` it results in an infinite loop
    # shellcheck disable=SC2119
    isFunction "$extend" || _argument printf -- "%s\n%s\n" "Unknown decoration name: $what ($extend)" "$(decorations)" || return $?
    __catchEnvironment "$usage" "$extend" "$@" || return $?
    return $?
  fi
  read -r lp dp text <<<"$style" || :
  local p='\033['
  __decorate "$text" "${p}${lp}m" "${p}${dp:-$lp}m" "${p}0m" "$@"
}
_decorate() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Enables timing
# Usage: {fn} style
# Exit Code: 1 - not found
# Exit Code: 0 - found
# stdout: 1, 2, or 3 tokens + newline: lightColor darkColor text
# Requires: printf
_caseStyles() {
  case "$1" in
    reset) lp='0' ;;
      # styles
    underline) lp='4' ;;
    no-underline) lp='24' ;;
    bold) lp='1' ;;
    no-bold) lp='21' ;;
      # colors
    black) lp='109;7' ;;
    black-contrast) lp='107;30' ;;
    blue) lp='94' ;;
    cyan) lp='36' ;;
    green) lp='92' ;;
    magenta) lp='35' ;;
    orange) lp='33' ;;
    red) lp='31' ;;
    white) lp='48;5;0;37' ;;
    yellow) lp='48;5;16;38;5;11' ;;
      # bold-colors
    bold-black) lp='1;109;7' ;;
    bold-black-contrast) lp='1;107;30' ;;
    bold-blue) lp='1;94' ;;
    bold-cyan) lp='1;36' ;;
    bold-green) lp='92' ;;
    bold-magenta) lp='1;35' ;;
    bold-orange) lp='1;33' ;;
    bold-red) lp='1;31' ;;
    bold-white) lp='1;48;5;0;37' ;;
    bold-yellow) lp='1;48;5;16;38;5;11' ;;
      # semantic-colors
    code) lp='1;97;44' ;;
    info) lp='38;5;20' && dp='1;33' && text="Info" ;;
    notice) lp='46;31' && dp='1;97;44' && text="Notice" ;;
    success) lp='42;30' && dp='0;32' && text="Success" ;;
    warning) lp='1;93;41' && text="Warning" ;;
    error) lp='1;91' && text="ERROR" ;;
    subtle) lp='1;38;5;252' && dp='1;38;5;240' ;;
    label) lp='34;103' && dp='1;96' ;;
    value) lp='1;40;97' && dp='1;97' ;;
    decoration) lp='45;97' && dp='45;30' ;;
    *)
      return 1
      ;;
  esac
  printf "%s %s %s\n" "$lp" "${dp:-$lp}" "$text"
}

# fn: decorate each
# Usage: decorate each decoration argument1 argument2 ...
# Runs the following command on each subsequent argument for formatting
# Example:     decorate each code "$@"
# Requires: decorate printf
__decorateExtensionEach() {
  local code="$1" formatted=()

  shift || return 0
  while [ $# -gt 0 ]; do
    formatted+=("$(decorate "$code" "$1")")
    shift
  done
  IFS=" " printf -- "%s\n" "${formatted[*]-}"
}

# fn: decorate quote
# Double-quote all arguments as properly quoted bash string
# Mostly $ and " are problematic within a string
# Requires: printf decorate
__decorateExtensionQuote() {
  local text="$*"
  text="${text//\"/\\\"}"
  text="${text//\$/\\\$}"
  printf -- "\"%s\"\n" "$text"
}

# IDENTICAL reverseFileLines 12

# Reverses a pipe's input lines to output using an awk trick.
#
# Not recommended on big files.
#
# Summary: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
# Depends: awk
reverseFileLines() {
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}

# IDENTICAL mapEnvironment 81

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
  __catchEnvironment "$__usage" _mapEnvironmentGenerateSedFile "$__prefix" "$__suffix" "${__ee[@]}" >"$__sedFile" || _clean $? "$__sedFile" || return $?
  __catchEnvironment "$__usage" sed -f "$__sedFile" || __throwEnvironment "$__usage" "$(cat "$__sedFile")" || _clean $? "$__sedFile" || return $?
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

# fn: {base}
# Usage: {fn}
# See `mapEnvironment` for arguments and usage.
# See: mapEnvironment
__binMapEnvironment() {
  mapEnvironment "$@"
}

__binMapEnvironment "$@"
