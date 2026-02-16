#!/usr/bin/env bash
#
# Map environment to values in a target file
#
# Example:     name=world map.sh name <<<"Hello, {name}."
#
# Copyright &copy; 2026 Market Acumen, Inc.

# IDENTICAL returnMessage 39

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.
# Argument: message ... - String. Optional. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf returnMessage
returnMessage() {
  local handler="_${FUNCNAME[0]}"
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  if [ "$code" = "--help" ]; then "$handler" 0 && return; fi
  isUnsignedInteger "$code" || returnMessage 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${handler#_} non-integer \"$code\"" "$@" || return $?
  if [ "$code" -gt 0 ]; then icon="❌ [$code]" && to=2; fi
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}
_returnMessage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Is value an unsigned integer?
# Test if a value is a 0 or greater integer. Leading "+" is ok.
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: returnMessage
isUnsignedInteger() {
  [ $# -eq 1 ] || returnMessage 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}
_isUnsignedInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL returnMessage

# IDENTICAL _tinySugar 72

# Run `handler` with an argument error
# Argument: handler - Function. Required. Error handler.
# Argument: message ... - String. Optional. Error message
throwArgument() {
  returnThrow 2 "$@" || return $?
}

# Run `handler` with an environment error
# Argument: handler - Function. Required. Error handler.
# Argument: message ... - String. Optional. Error message
throwEnvironment() {
  returnThrow 1 "$@" || return $?
}

# Run `command`, upon failure run `handler` with an argument error
# Argument: handler - String. Required. Failure command
# Argument: command ... - Required. Command to run.
# Requires: throwArgument
catchArgument() {
  local handler="${1-}"
  shift && "$@" || throwArgument "$handler" "$@" || return $?
}

# Run `command`, upon failure run `handler` with an environment error
# Argument: handler - String. Required. Failure command
# Argument: command ... - Required. Command to run.
# Requires: throwEnvironment
catchEnvironment() {
  local handler="${1-}"
  shift && "$@" || throwEnvironment "$handler" "$@" || return $?
}

# _IDENTICAL_ _errors 36

# Return `argument` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Return Code: 2
# Requires: returnMessage
returnArgument() {
  returnMessage 2 "$@" || return $?
}

# Return `environment` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Return Code: 1
# Requires: returnMessage
returnEnvironment() {
  returnMessage 1 "$@" || return $?
}

# Run `handler` with a passed return code
# Argument: returnCode - Integer. Required. Return code.
# Argument: handler - Function. Required. Error handler.
# Argument: message ... - String. Optional. Error message
# Requires: returnArgument
returnThrow() {
  local returnCode="${1-}" && shift || returnArgument "Missing return code" || return $?
  local handler="${1-}" && shift || returnArgument "Missing error handler" || return $?
  "$handler" "$returnCode" "$@" || return $?
}

# Run binary and catch errors with handler
# Argument: handler - Function. Required. Error handler.
# Argument: binary ... - Executable. Required. Any arguments are passed to `binary`.
# Requires: returnArgument
catchReturn() {
  local handler="${1-}" && shift || returnArgument "Missing handler" || return $?
  "$@" || "$handler" "$?" "$@" || return $?
}

# <-- END of IDENTICAL _tinySugar

usageDocument() {
  usageDocumentSimple "$@"
}

# IDENTICAL __usageDocumentCached 25

# Argument: handler - Function. Required.
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to display usage for
# Environment: BUILD_COLORS
# Requires: decorateThemed catchEnvironment
__usageDocumentCached() {
  local handler="${1-}" && shift
  local home="${1-}" && shift
  local functionName="${1-}" && shift
  local suffix="bin/build/documentation/$functionName.sh"
  local settingsFile="$home/$suffix"
  [ -f "$settingsFile" ] || return 1
  decorateInitialized || decorate info -- || return $?
  (
    local helpConsole="" helpPlain="no helpPlain in $suffix"
    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settingsFile" || return $?
    if [ "${BUILD_COLORS-}" != "false" ] && [ -n "$helpConsole" ]; then
      catchEnvironment "$handler" decorateThemed <<<"$helpConsole" || return $?
    else
      catchEnvironment "$handler" printf "%s\n" "$helpPlain" || return $?
    fi
  ) || return $?
}

# IDENTICAL usageDocumentSimple 33

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - String. Optional. Message to display to the user.
# Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached
usageDocumentSimple() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" color helpColor="info" icon="❌" skip=false && shift 3

  case "$returnCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="red" ;; *) color="orange" ;; esac
  [ "$returnCode" -eq 0 ] || exec 1>&2
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(returnCodeString "$returnCode")")" "$(decorate BOLD "$color" "$*")"
  export BUILD_HOME
  if [ ! -f "$source" ]; then
    [ -d "${BUILD_HOME-}" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
    source="$BUILD_HOME/$source"
    [ -f "$source" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
  fi
  if ! __usageDocumentCached "$handler" "${BUILD_HOME-}" "${functionName}"; then
    bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g" | decorate "$helpColor"
  fi
  return "$returnCode"
}
_usageDocumentSimple() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL bashFunctionComment 48

# Extracts the final comment from a stream
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Requires: fileReverseLines sed cut grep convertValue
bashFinalComment() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  grep -v -e '\(shellcheck \| IDENTICAL \|_IDENTICAL_\|DOC TEMPLATE:\|Internal:\|INTERNAL:\)' | fileReverseLines | sed -n -e 1d -e '/^[[:space:]]*#/ { p'$'\n''b'$'\n''}; q' | sed -e 's/^[[:space:]]*#[[:space:]]//' -e 's/^[[:space:]]*#$//' | fileReverseLines || :
  # Explained:
  # - grep -v ... - Removes internal documentation and anything we want to hide from the user
  # - fileReverseLines - First reversal to get that comment, file lines are reverse ordered
  # - `sed 1d` - Deletes the first line (e.g. the `function() { ` which was the LAST thing in the line and is now our first line
  # - `sed -n` - disables automatic printing
  # - `sed -e '/^[[:space:]]*#/ { p'$'\n''b'$'\n''}; q'` - while matching `[space]#` print lines then quit when does not match
  # - `sed -e 's/^[[:space:]]*#[[:space:]]//' -e 's/^[[:space:]]*#$//' - trim comment character and first space after
  # - Why the odd $'\n'? See https://stackoverflow.com/questions/15467616/sed-gives-me-unexpected-eof-pending-s-error-and-i-have-no-idea-why ... On BSD sed you must use newlines between statements.
  # - fileReverseLines - File is back to normal
}
_bashFinalComment() {
  ! false || bashFinalComment --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract a bash comment from a file. Excludes lines containing the following tokens:
#
# - `" IDENTICAL "` or `"_IDENTICAL_"`
# - `"Internal:"` or `"INTERNAL:"`
# - `"DOC TEMPLATE:"`
#
# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Requires: grep cut fileReverseLines __help
# Requires: usageDocument
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  __help "_${FUNCNAME[0]}" "$@" || return 0
  grep -m 1 -B $maxLines -e "^\s*$functionName() {" "$source" | bashFinalComment
  # Explained:
  # - grep -m 1 ... - Finds the `function() {` string in the file and all lines beforehand (up to 1000 lines)
}
_bashFunctionComment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# _IDENTICAL_ convertValue 37

# map a value from one value to another given from-to pairs
#
# Prints the mapped value to stdout
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: value - String. A value.
# Argument: from - String. When value matches `from`, instead print `to`
# Argument: to - String. The value to print when `from` matches `value`
# Argument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match
convertValue() {
  local __handler="_${FUNCNAME[0]}" value="" from="" to=""
  # __IDENTICAL__ __checkHelp1__handler 1
  [ "${1-}" != "--help" ] || __help "$__handler" "$@" || return 0

  while [ $# -gt 0 ]; do
    if [ -z "$value" ]; then
      value=$(validate "$__handler" string "value" "$1") || return $?
    elif [ -z "$from" ]; then
      from=$(validate "$__handler" string "from" "$1") || return $?
    elif [ -z "$to" ]; then
      to=$(validate "$__handler" string "to" "$1") || return $?
      if [ "$value" = "$from" ]; then
        printf "%s\n" "$to"
        return 0
      fi
      from="" && to=""
    fi
    shift
  done
  printf "%s\n" "${value:-0}"
}
_convertValue() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL __help 57

# Simple help argument handler.
#
# Easy `--help` handler for any function useful when it's the only option.
#
# Useful for utilities which single argument types, single arguments, and no arguments (except for `--help`)
#
# Oddly one of the few functions we can not offer the `--help` flag for.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: --only - Flag. Optional. Must be first parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: handlerFunction - Function. Required. Must be first or second parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: arguments ... - Arguments. Optional. Arguments passed to calling function to check for `--help` argument.
#
# Example:     # NOT DEFINED handler
# Example:
# Example:     __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
# Example:     # Argument 1 absolutely exists
# Example:     [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:
# Example:     # DEFINED handler
# Example:
# Example:     local handler="_${FUNCNAME[0]}"
# Example:     __help "$handler" "$@" || return 0
# Example:     [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
# Example:     [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
# Example:
# Example:     # Blank Arguments for help
# Example:     [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
# Example:     [ $# -gt 0 ] || __help "$handler" --help || return 0
#
# DEPRECATED-Example: [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return $?
# DEPRECATED-Example: [ $# -eq 0 ] || __help --only "$handler" "$@" || return $?
#
# Requires: throwArgument usageDocument ___help
__help() {
  [ $# -gt 0 ] || ! ___help 0 || return 0
  local flag="--help"
  local handler="${1-}" && shift
  if [ "$handler" = "--only" ]; then
    handler="${1-}" && shift
    [ $# -gt 0 ] || return 0
    [ "$#" -eq 1 ] && [ "${1-}" = "$flag" ] || throwArgument "$handler" "Only argument allowed is \"$flag\": $*" || return $?
  fi
  while [ $# -gt 0 ]; do
    [ "$1" != "$flag" ] || ! "$handler" 0 || return 1
    shift
  done
  return 0
}
___help() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL isCallable 46

# Test if all arguments are callable as a command
# Argument: string - EmptyString. Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - All arguments are callable as a command
# Return Code: 1 - One or or more arguments are callable as a command
# Requires: throwArgument __help isExecutable isFunction
isCallable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || throwArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if ! isFunction "$1" && ! isExecutable "$1"; then
    return 1
  fi
}
_isCallable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if all arguments are executable binaries
# Argument: string - String. Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - All arguments are executable binaries
# Return Code: 1 - One or or more arguments are not executable binaries
# Requires: throwArgument  __help catchEnvironment command
isExecutable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || throwArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  if [ -f "$1" ]; then
    # Docker has an issue when you mount a local volume inside a container
    # Executable files, inside the container within the mounted volume report as non-executable via `-x` but
    # Report *correctly* when you use `ls`.
    local mode && mode=$(catchEnvironment "$handler" ls -l "$1") || return $?
    mode="${mode%% *}" && [ "${mode#*x}" != "$mode" ]
  else
    [ -n "$(which "$1")" ]
  fi
}
_isExecutable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _type 42

# Test if an argument is a positive integer (non-zero)
# Takes one argument only.
# Argument: value - EmptyString. Required. Value to check if it is an unsigned integer
# Return Code: 0 - if it is a positive integer
# Return Code: 1 - if it is not a positive integer
# Requires: catchArgument isUnsignedInteger usageDocument
isPositiveInteger() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if isUnsignedInteger "${1-}"; then
    [ "$1" -gt 0 ] || return 1
    return 0
  fi
  return 1
}
_isPositiveInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if argument are bash functions
# Argument: string - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - argument is bash function
# Return Code: 1 - argument is not a bash function
# Requires: catchArgument isUnsignedInteger usageDocument type
isFunction() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
_isFunction() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# _IDENTICAL_ returnCodeString 15

# Output the exit code as a string
#
# INTERNAL: Winner of the one-line bash award 10 years running
# Argument: code ... - UnsignedInteger. String. Exit code value to output.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# stdout: exitCodeToken, one per line
returnCodeString() {
  local k="" && while [ $# -gt 0 ]; do case "$1" in 0) k="success" ;; 1) k="environment" ;; 2) k="argument" ;; 97) k="assert" ;; 105) k="identical" ;; 108) k="leak" ;; 116) k="timeout" ;; 120) k="exit" ;; 127) k="not-found" ;; 130) k="user-interrupt" ;; 141) k="interrupt" ;; 253) k="internal" ;; 254) k="unknown" ;; --help) "_${FUNCNAME[0]}" 0 && return $? || return $? ;; *) k="[returnCodeString unknown \"$1\"]" ;; esac && [ -n "$k" ] || k="$1" && printf "%s\n" "$k" && shift; done
}
_returnCodeString() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL validate 132

# Summary: Validate a value by type
# Argument: handler - Function. Required. Error handler.
# Argument: type - Type. Required. Type to validate. If more than validation set is specified, specifying a `type` of "" inherits the previous `type`. Blank `types` are not allowed.
# Argument: name - String. Required. Name of the variable which is being validated. If more than validation set is specified, specifying a name of "" inherits the previous name. Blank names are not allowed.
# Argument: value - EmptyString. Required. Value to validate.
#
# Validation sets are passed as three arguments, optionally repeated: `type` `name ` `value`
#
# Types are case-insensitive:
#
# #### Text and formats
#
# - `EmptyString` - (alias `string?`, `any`) - Any value at all
# - `String` - (no aliases) - Any non-empty string
# - `EnvironmentVariable` - (alias `env`) - A non-empty string which contains alphanumeric characters or the underscore and does not begin with a digit.
# - `Secret` - (no aliases) - A value which is security sensitive
# - `Date` - (no aliases) - A valid date in the form `YYYY-MM-DD`
# - `URL` - (no aliases) - A Universal Resource Locator in the form `scheme://user:password@host:port/path`
#
# #### Numbers
#
# - `Flag` - (no aliases) - Presence of an option to enables a feature. (e.g. `--debug` is a `flag`)
# - `Boolean` - (alias `bool`) - A value `true` or `false`
# - `BooleanLike` - (aliases `boolean?`, `bool?`) - A value which should be evaluated to a boolean value
# - `Integer` - (alias `int`) - Any integer, positive or negative
# - `UnsignedInteger` - (aliases `uint`, `unsigned`) - Any integer 0 or greater
# - `PositiveInteger` - (alias `positive`) - Any integer 1 or greater
# - `Number` - (alias `number`) - Any integer or real number
#
# #### File system
#
# - `Exists` - (no aliases - A file (or directory) which exists in the file system of any type
# - `File` - (no aliases) - A file which exists in the file system which is not any special type
# - `Link` - (no aliases) - A link which exists in the file system
# - `Directory` - (alias `dir`) - A directory which exists in the file system
# - `DirectoryList` - (alias `dirlist`) - One or more directories as arguments
# - `FileDirectory` - (alias `parent`) - A file whose directory exists in the file system but which may or may not exist.
# - `RealDirectory` - (alias `realdir`) - The real path of a directory which must exist.
# - `RealFile` - (alias `real`) - The real path of a file which must exist.
# - `RemoteDirectory` - (alias `remotedir`) - The path to a directory on a remote host.
#
# #### Application-relative
#
# - `ApplicationDirectory` - (alias `appdir`) - A directory path relative to `BUILD_HOME`
# - `ApplicationFile` - (alias `appfile`) - A file path relative to `BUILD_HOME`
# - `ApplicationDirectoryList` - (alias `appdirlist`) - One or more arguments of type `ApplicationDirectory`
#
# #### Functional
#
# - `Function` - (alias `function`) - A defined function
# - `Callable` - (alias `callable`) - A function or executable
# - `Executable` - (alias `bin`) - Any binary available within the `PATH`
#
# #### Lists
#
# - `Array` - (no aliases) - Zero or more arguments
# - `List` - (no  aliases) - Zero or more arguments
# - `ColonDelimitedList` - (alias `list:`) - A colon-delimited list `:`
# - `CommaDelimitedList` - (alias `list,`) - A comma-delimited list `,`
#
# You can repeat the `type` `name` `value` more than once in the arguments and each will be checked until one fails
# Return Code: 0 - Valid is valid, stdout is a filtered version of the value to be used
# Return Code: 2 - Valid is invalid, output reason to stderr
# Requires: __validateTypeString __validateTypePositiveInteger __validateTypeFunction __validateTypeCallable
# Requires: isFunction throwArgument __help decorate
validate() {
  local handler="_${FUNCNAME[0]}"
  local prefix="__validateType"

  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ $# -ge 4 ] || throwArgument "$handler" "Missing arguments - expect 4 or more (#$#: $(decorate each code -- "$@"))" || return $?

  local handler="$1" && shift

  local name="" index=0
  while [ $# -ge 3 ]; do
    index=$((index + 1))
    local type="$1" value="$3"
    name="${2:-"$name"}"
    [ -n "$name" ] || throwArgument "$handler" "name required" || return $?
    if isFunction _validateTypeMapper; then
      type=$(_validateTypeMapper "$type")
    fi
    local typeFunction="$prefix$type"
    isFunction "$typeFunction" || throwArgument "$handler" "validate $type is not a valid type:"$'\n'"$(validateTypeList)" || return $?
    # Outputs stdout value if successful
    if ! "$typeFunction" "$value"; then
      local suffix="" ess="s" && [ "${#value}" -ne 1 ] || ess=""
      [ -z "$value" ] || suffix=" $(decorate error "$value")"
      throwArgument "$handler" "$name (#$index \"$(decorate code "$value")\" [${#value} char$ess]) is not type $(decorate label "$type")$suffix" || return $?
    fi
    shift 3
  done
}
_validate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# output arguments to stderr and return the argument error
# Return: 2
# Return Code: 2 - Argument error
_validateThrow() {
  printf -- "%s\n" "$@" 1>&2
  return 2
}

# Non-empty string
# Requires: _validateThrow
__validateTypeString() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  printf "%s\n" "${1-}"
}

# Requires: isPositiveInteger _validateThrow
__validateTypePositiveInteger() {
  isPositiveInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}

# Requires: isFunction _validateThrow
__validateTypeFunction() {
  isFunction "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}

# Requires: isCallable _validateThrow
__validateTypeCallable() {
  isCallable "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}

# IDENTICAL decorate 288

# Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 0 - Console or output supports colors
# Return Code: 1 - Colors are likely not supported by console
# Environment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.
# Requires: isPositiveInteger tput
consoleHasColors() {
  # --help is only argument allowed
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"

  # Values allowed for this global are true and false
  # Important: DO NOT use buildEnvironmentLoad BUILD_COLORS TERM
  export BUILD_COLORS
  if [ -z "${BUILD_COLORS-}" ]; then
    BUILD_COLORS=false
    case "${TERM-}" in "" | "dumb" | "unknown") BUILD_COLORS=true ;; *)
      local termColors
      termColors="$(tput colors 2>/dev/null)"
      isPositiveInteger "$termColors" || termColors=2
      [ "$termColors" -lt 8 ] || BUILD_COLORS=true
      ;;
    esac
  elif [ "${BUILD_COLORS-}" != "true" ]; then
    BUILD_COLORS=false
  fi
  [ "${BUILD_COLORS-}" = "true" ]
}
_consoleHasColors() {
  true || consoleHasColors --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Semantics-based
#
# Argument: label - Text label
# Argument: lightStartCode - Escape code label for light mode (color)
# Argument: endCode - Escape end code
# Argument: text ... - Text to output.
# Requires: consoleHasColors printf
__decorate() {
  local prefix="$1" start="$2" end="$3" && shift 3
  export BUILD_COLORS
  if [ -n "${BUILD_COLORS-}" ] && [ "${BUILD_COLORS-}" = "true" ] || [ -z "${BUILD_COLORS-}" ] && consoleHasColors; then
    if [ $# -eq 0 ]; then printf -- "%s$start" ""; else printf -- "$start%s$end\n" "$*"; fi
    return 0
  fi
  [ $# -gt 0 ] || return 0
  if [ -n "$prefix" ]; then printf -- "%s: %s\n" "$prefix" "$*"; else printf -- "%s\n" "$*"; fi
}

# Output a list of build-in decoration styles, one per line
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
decorations() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" reset \
    underline no-underline bold no-bold \
    black black-contrast blue cyan green magenta orange red white yellow \
    code info notice success warning error subtle label value decoration
}
_decorations() {
  ! false || decorations --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Singular decoration function
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration
# Argument: text ... - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for `style`.
# You can extend this function by writing a your own extension `__decorationExtensionCustom` is called for `decorate custom`.
# stdout: Decorated text
# Environment: __BUILD_DECORATE - String. Cached color lookup.
# Environment: BUILD_COLORS - Boolean. Colors enabled (`true` or `false`).
# Requires: isFunction returnArgument awk catchEnvironment usageDocument executeInputSupport __help
decorate() {
  local handler="_${FUNCNAME[0]}" what="${1-}"
  [ "$what" != "--help" ] || __help "$handler" "$@" || return 0
  [ -n "$what" ] || catchArgument "$handler" "Requires at least one argument: \"$*\"" || return $?
  local style && shift && catchReturn "$handler" _decorateInitialize || return $?
  if ! style=$(__decorateStyle "$what"); then
    local extend func="${what/-/_}"
    extend="__decorateExtension$(printf "%s" "${func:0:1}" | awk '{print toupper($0)}')${func:1}"
    # When this next line calls `catchArgument` it results in an infinite loop, so don't - use returnArgument
    # shellcheck disable=SC2119
    if isFunction "$extend"; then
      executeInputSupport "$handler" "$extend" -- "$@" || return $?
      return 0
    else
      executeInputSupport "$handler" __decorate "❌" "[$what ☹️" "]" -- "$@" || return 2
    fi
  fi
  local lp text="" && IFS=" " read -r lp text <<<"$style" || :
  local p='\033['
  executeInputSupport "$handler" __decorate "$text" "${p}${lp}m" "${p}0m" -- "$@" || return $?
}
_decorate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is the decorate color system initialized yet?
# Useful to set our global color environment at the top level of a script if it hasn't been initialized already.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# shellcheck disable=SC2120
decorateInitialized() {
  [ "${1-}" != "--help" ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ]
}
_decorateInitialized() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_decorateInitialize() {
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ] || __decorateStyles || return $?
}

# Fetch the requested style as a string: lp dp text
# dp may be a dash for simpler parsing - dp=lp when dp is blank or dash
# text is optional, lp is required to be non-blank
# Requires: __decorateStyles
__decorateStyle() {
  local original style pattern=":$1="

  original="${__BUILD_DECORATE}"
  style="${__BUILD_DECORATE#*"$pattern"}"
  [ "$style" != "$original" ] || return 1
  printf "%s\n" "${style%%:*}"
}

# Default array styles, override if you wish
if ! isFunction __decorateStyles; then
  # This sets __BUILD_DECORATE to the styles strings
  __decorateStyles() {
    __decorateStylesDefaultLight || __decorateStylesDefaultDark # Solely for link
  }
fi

# Default array styles, override if you wish
__decorateStylesBase() {
  local styles=":reset=0:underline=4:no-underline=24:bold=1:no-bold=21:black=109;7:black-contrast=107;30:blue=94:cyan=36:green=92:magenta=35:orange=33:red=31:white=48;5;0;37:yellow=48;5;16;38;5;11:"
  styles="$styles:$(printf "%s:" "$@")"
  styles="$styles:code=1;97;44:warning=1;93;41 Warning:error=1;91 ERROR:"
  export __BUILD_DECORATE
  __BUILD_DECORATE="$styles"
}
__decorateStylesDefaultLight() {
  local aa=(
    "info=38;5;20 Info"
    "notice=46;31 Notice"
    "success=42;30 Success"
    "subtle=1;38;5;252"
    "label=34;103"
    "value=30;107"
    "decoration=45;97"
  )
  __decorateStylesBase "${aa[@]}"
}
__decorateStylesDefaultDark() {
  local aa=(
    "info=33 Info"
    "notice=97;44 Notice"
    "success=0;32 Success"
    "subtle=38;5;240"
    "label=96;40"
    "value=94"
    "decoration=45;30"
  )
  __decorateStylesBase "${aa[@]}"
}

# fn: decorate each
# Runs the following command on each subsequent argument for formatting
# Also supports formatting input lines instead (on the same line)
# Example:     decorate each code -- "$@"
# Requires: decorate printf
# Argument: style - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.
# Argument: -- - Flag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.
# Argument: --index - Flag. Optional. Show the index of each item before with a colon. `0:first 1:second` etc.
# Argument: --count - Flag. Optional. Show the count of items in the list after the list is generated.
__decorateExtensionEach() {
  local __saved=("$@") __count=$#
  local formatted=() item addIndex=false showCount=false index=0 prefix="" style=""

  while [ $# -gt 0 ]; do
    case "$1" in --index) addIndex=true ;; --count) showCount=true ;; --arguments) showCount=true ;;
    "") throwArgument "$handler" "Blank argument" || return $? ;;
    *) style="$1" && shift && break ;;
    esac
    shift
  done
  local codes=("$style")
  if [ "$style" != "${style#*,}" ]; then
    IFS="," read -r -a codes <<<"$style"
    [ "${#codes[@]}" -gt 0 ] || throwArgument "$handler" "Blank style passed to each: \"$style\" (${__saved[*]})"
  fi
  if [ $# -eq 0 ]; then
    local byte
    if read -r -t 1 -n 1 byte; then
      if [ "$byte" = $'\n' ]; then
        formatted+=("$prefix$(decorate "${codes[@]}" "")")
        byte=""
      fi
      local done=false
      while ! $done; do
        IFS='' read -r item || done=true
        [ -n "$byte$item" ] || ! $done || break
        ! $addIndex || prefix="$index:"
        formatted+=("$prefix$(decorate "${codes[@]}" "$byte$item")")
        byte=""
        index=$((index + 1))
      done
    fi
  else
    while [ $# -gt 0 ]; do
      ! $addIndex || prefix="$index:"
      item="$1"
      formatted+=("$prefix$(decorate "${codes[@]}" -- "$item")")
      shift
      index=$((index + 1))
    done
  fi
  ! $showCount || formatted+=("[$index]")
  IFS=" " printf -- "%s\n" "${formatted[*]-}"
}

# fn: decorate BOLD
# Argument: style - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.
# Argument: text ... - EmptyString. Optional. Text to format. Use `--` to output begin codes only.
__decorateExtensionBOLD() {
  local style="${1-}" && shift
  case "$style" in
  "" | "-" | "--")
    decorate bold "$*"
    return 0
    ;;
  esac
  local codes=("$style")
  if [ "$style" != "${style#*,}" ]; then
    IFS="," read -r -a codes <<<"$style"
    [ "${#codes[@]}" -gt 0 ] || throwArgument "$handler" "Blank style passed to BOLD: \"$style\" (${__saved[*]})"
  fi
  if [ "$*" != "--" ]; then
    if [ $# -eq 0 ]; then
      decorate "${codes[@]}" | decorate bold
    else
      decorate bold "$(decorate "${codes[@]}" -- "$@")"
    fi
  else
    decorate bold --
    decorate "${codes[@]}" --
  fi
}

# fn: decorate quote
# Double-quote all arguments as properly quoted bash string
# Mostly $ and " are problematic within a string
# Requires: printf decorate
__decorateExtensionQuote() {
  if [ $# -eq 0 ]; then
    local finished=false
    while ! $finished; do
      local line="" && IFS="" read -d $'\n' -r line || finished=true
      [ -n "$line" ] || ! $finished || continue
      __decorateExtensionQuoteProcessLine "$line" || return $?
    done
  else
    __decorateExtensionQuoteProcessLine "$@" || return $?
  fi
}

# Argument: text ... - String. Text to quote
__decorateExtensionQuoteProcessLine() {
  local text="$*"
  text="${text//\"/\\\"}"
  text="${text//\$/\\\$}"
  printf -- "\"%s\"\n" "$text"
}

# <-- END of IDENTICAL decorate
# <-- END of IDENTICAL decorate

# IDENTICAL executeInputSupport 39

# Support arguments and stdin as arguments to an executor
# Argument: executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial `--`.
# Argument: -- - Alone after the executor forces `stdin` to be ignored. The `--` flag is also removed from the arguments passed to the executor.
# Argument: ... - Any additional arguments are passed directly to the executor
executeInputSupport() {
  local handler="$1" executor=() && shift

  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    executor+=("$1")
    shift
  done
  [ ${#executor[@]} -gt 0 ] || return 0

  local byte
  # On Darwin `read -t 0` DOES NOT WORK as a select on stdin
  if [ $# -eq 0 ] && IFS="" read -r -t 1 -n 1 byte; then
    local line done=false
    if [ "$byte" = $'\n' ]; then
      catchEnvironment "$handler" "${executor[@]}" "" || return $?
      byte=""
    fi
    while ! $done; do
      IFS="" read -r line || done=true
      [ -n "$byte$line" ] || ! $done || break
      catchEnvironment "$handler" "${executor[@]}" "$byte$line" || return $?
      byte=""
    done
  else
    if [ "${1-}" = "--" ]; then
      shift
    fi
    catchEnvironment "$handler" "${executor[@]}" "$@" || return $?
  fi
}

# IDENTICAL fileTemporaryName 34

# Wrapper for `mktemp`. Generate a temporary file name, and fail using a function
# Argument: handler - Function. Required. Function to call on failure. Function Type: returnMessage
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: ... - Arguments. Optional. Any additional arguments are passed through.
# Requires: mktemp __help catchEnvironment usageDocument
# BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks
# Environment: BUILD_DEBUG
fileTemporaryName() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  handler="$1" && shift
  local debug=",${BUILD_DEBUG-},"
  if [ "${debug#*,temp,}" != "$debug" ]; then
    local target="${BUILD_HOME-.}/.${FUNCNAME[0]}"
    printf "%s" "fileTemporaryName: " >>"$target"
    catchEnvironment "$handler" mktemp "$@" | tee -a "$target" || return $?
    local sources=() count=${#FUNCNAME[@]} index=0
    while [ "$index" -lt "$count" ]; do
      sources+=("${BASH_SOURCE[index + 1]-}:${BASH_LINENO[index]-"$LINENO"} - ${FUNCNAME[index]-}")
      index=$((index + 1))
    done
    printf "%s\n" "${sources[@]}" "-- END" >>"$target"
  else
    catchEnvironment "$handler" mktemp "$@" || return $?
  fi
}
_fileTemporaryName() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName

# IDENTICAL fileReverseLines 18

# Reverses a pipe's input lines to output using an awk trick.
#
# Not recommended on big files.
#
# Summary: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
# Depends: awk
fileReverseLines() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}
_fileReverseLines() {
  true || fileReverseLines --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL environmentVariables 19

# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Requires: declare grep cut usageDocument __help
environmentVariables() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  {
    declare -px | grep 'declare -x ' | cut -f 1 -d "=" | cut -f 3 -d " " && declare -ax | grep 'declare -ax ' | cut -f 1 -d '=' | cut -f 3 -d " "
  } | catchReturn "$handler" sort -u || return $?
}
_environmentVariables() {
  true || environmentVariables --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL mapEnvironment 88

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# This one does it like `mapValue`
# Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination.
# See: mapValue
# Argument: environmentVariableName - String. Optional. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.
# Argument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
# Argument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: environmentVariables cat throwEnvironment catchEnvironment
# Requires: throwArgument decorate validate
# shellcheck disable=SC2120
mapEnvironment() {
  local handler="_${FUNCNAME[0]}"

  local __prefix='{' __suffix='}' __ee=() __searchFilters=() __replaceFilters=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix) shift && __prefix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --suffix) shift && __suffix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --search-filter) shift && __searchFilters+=("$(validate "$handler" Callable "searchFilter" "${1-}")") || return $? ;;
    --replace-filter) shift && __replaceFilters+=("$(validate "$handler" Callable "replaceFilter" "${1-}")") || return $? ;;
    --env-file) shift && muzzle validate "$handler" LoadEnvironmentFile "$argument" "${1-}" || return $? ;;
    *) __ee+=("$(validate "$handler" String "environmentVariableName" "$argument")") || return $? ;;
    esac
    shift
  done

  # If no environment variables are passed on the command line, then use all of them
  local __e
  if [ "${#__ee[@]}" -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi

  (
    local __filter __value __handler="$handler"
    unset handler

    __value="$(catchEnvironment "$__handler" cat)" || return $?
    if [ $((${#__replaceFilters[@]} + ${#__searchFilters[@]})) -gt 0 ]; then
      for __e in "${__ee[@]}"; do
        case "${__e}" in *[!A-Za-z0-9_]*) continue ;; *) ;; esac
        local __search="$__prefix$__e$__suffix"
        local __replace="${!__e-}"
        if [ ${#__searchFilters[@]} -gt 0 ]; then
          for __filter in "${__searchFilters[@]}"; do
            __search=$(catchEnvironment "$__handler" "$__filter" "$__search") || return $?
          done
        fi
        if [ ${#__replaceFilters[@]} -gt 0 ]; then
          for __filter in "${__replace[@]}"; do
            __replace=$(catchEnvironment "$__handler" "$__filter" "$__replace") || return $?
          done
        fi
        __value="${__value//"$__search"/$__replace}"
      done
    else
      for __e in "${__ee[@]}"; do
        case "${__e}" in *[!A-Za-z0-9_]*) continue ;; *) ;; esac
        local __search="$__prefix$__e$__suffix"
        local __replace="${!__e-}"
        __value="${__value//"$__search"/$__replace}"
      done
    fi
    printf "%s\n" "$__value"
  )
}
_mapEnvironment() {
  decorateInitialized || decorate info --
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# fn: {base}
# See `mapEnvironment` for arguments and usage.
# See: mapEnvironment
__binMapEnvironment() {
  mapEnvironment "$@"
}

__binMapEnvironment "$@"
