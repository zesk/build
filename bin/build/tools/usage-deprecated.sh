#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Argument: defaultNoun - String. Required. Default noun if user noun is empty
# Argument: usageFunction - Function. Required. Error handler
# Argument: variableName - String. Required. Name to test
# Argument: variableValue - EmptyString. Required. Value to test
# Argument: noun - EmptyString. Required. Noun passed by user
# Argument: testCommand ... - Callable. Required. Test command to run on value.
# Utility function to handle all handler
#
__catchArgumentHelper() {
  local defaultNoun usageFunction variableName variableValue noun

  defaultNoun="${1-}"
  shift || :
  usageFunction="${1-}"
  shift || :
  variableName="${1-}"
  shift || :
  variableValue="${1-}"
  shift || :
  noun="${1:-"$defaultNoun"}"
  shift || :
  [ -n "$variableValue" ] || throwArgument "$usageFunction" "$variableName $noun is required ($(decorate code "$variableValue"))" || return $?

  # Remaining parameters are the test
  "$@" "$variableValue" || throwArgument "$usageFunction" "$variableName is not $noun (\"$(decorate code "$variableValue")$(decorate error '")')" || return $?

  printf "%s\n" "$variableValue"
}

# Require an argument to be non-blank
# Argument: handler - Function. Required. Usage function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be non-blank otherwise an argument error is thrown.
# Return Code: 2 - If `value` is blank
# Return Code: 0 - If `value` is non-blank
# Requires: throwArgument
usageArgumentString() {
  local handler="$1" argument="$2"
  shift 2 || :
  [ -n "${1-}" ] || throwArgument "$handler" "blank" "$argument" || return $?
  printf "%s\n" "$1"
}

# Validates a value is an positive integer and greater than zero (NOT zero)
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Return Code: 2 - Argument error
# Return Code: 0 - Success
# Requires: isPositiveInteger throwArgument decorate
usageArgumentPositiveInteger() {
  local handler="$1"
  [ $# -eq 3 ] || throwArgument "$handler" "${FUNCNAME[0]} Need 3 arguments ($#)" || return $?
  shift && isPositiveInteger "${2-}" || throwArgument "$handler" "${1-} not a positive integer: $(decorate code "${2-}")" || return $?
  printf "%s\n" "$2"
}

# Validates a value is an unsigned integer and greater than zero (or equal to zero)
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `unsigned integer`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
# Requires: isUnsignedInteger throwArgument decorate
usageArgumentUnsignedInteger() {
  local handler="$1" args
  [ $# -eq 3 ] || throwArgument "$handler" "${FUNCNAME[0]} Need 3 arguments ($#)" || return $?
  shift && isUnsignedInteger "${2-}" || throwArgument "$handler" "${1-} not an unsigned integer: $(decorate code "${2-}")" || return $?
  printf "%s\n" "$2"
}

# Validates a value is an integer
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `integer`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentInteger() {
  local args handler="$1"
  args=("$@")
  args[3]="${4-}"
  [ ${#args[@]} -eq 4 ] || throwArgument "$handler" "Need 4 arguments" || return $?
  __catchArgumentHelper integer "${args[@]}" isInteger || return $?
}

# Validates a value is a number
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `integer`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentNumber() {
  local args handler="$1"
  args=("$@")
  args[3]="${4-}"
  [ ${#args[@]} -eq 4 ] || throwArgument "$handler" "Need 4 arguments" || return $?
  __catchArgumentHelper integer "${args[@]}" isNumber || return $?
}

# Validates a value is not blank and is a file.
# Upon success, outputs the file name
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Value to test.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `file`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentFile() {
  local handler="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "file" "${args[@]}" test -f || return $?
}

# Validates a value is not blank and is a file and does `realPath` on it.
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Value to test.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `file`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentRealFile() {
  local handler="$1" args value
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
  fi

  value="$(__catchArgumentHelper "file" "${args[@]}" test -f)" || return $?
  catchEnvironment "$handler" realPath "$value" || return $?
}

# Validates a value is not blank and exists in the file system
# Upon success, outputs the file name
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `file or directory`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentExists() {
  local handler="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "file or directory" "${args[@]}" test -e || return $?
}

# Validates a value is not blank and is a link
# Upon success, outputs the file name
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Path to a link file.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `link`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentLink() {
  local handler="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "link" "${args[@]}" test -L || return $?
}

# Validates a value is not blank and is a directory. Upon success, outputs the directory name trailing slash stripped.
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `directory`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentDirectory() {
  local handler="$1" args directory
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  directory="$(__catchArgumentHelper "directory" "${args[@]}" test -d)" || return $?
  [ "${#directory}" -le 1 ] || directory="${directory%/}"
  printf "%s\n" "${directory}"
}

# Validates a value as a directory search list. Upon success, outputs the entire list, cleans up any invalid values or trailing characters.
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `directory list`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentDirectoryList() {
  local handler="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  local directories=() directory result=() index=0
  IFS=":" read -r -a directories <<<"$3" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    [ -n "$directory" ] || continue
    [ -d "$directory" ] || throwArgument "$handler" "$2 element #$index is not a directory $(decorate code "$directory"): $(decorate value "$3")" || return $?
    result+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${result[@]+"${result[@]}"}")"
}

# Validates a value as an application-relative directory search list. Upon success, outputs the entire list, cleans up any invalid values or trailing characters.
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `directory list`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentApplicationDirectoryList() {
  local handler="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi

  local home directories=() directory result=() index=0

  home=$(catchReturn "$handler" buildHome) || return $?
  IFS=":" read -r -a directories <<<"$3" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    [ -n "$directory" ] || continue
    directory="${directory#./}"
    directory="${directory#/}"
    directory="${directory%/}"
    [ -d "${home%/}/$directory" ] || throwArgument "$handler" "$2 element #$index is not a directory $(decorate code "$home/$directory"): $(decorate value "$3")" || return $?
    result+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${result[@]+"${result[@]}"}")"
}

# Validates a value as an application-relative directory. Upon success, outputs relative path.
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `directory list`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentApplicationDirectory() {
  local handler="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  local home directory="$3"

  [ -n "$directory" ] || throwArgument "$handler" "$directory is blank" || return $?
  home=$(catchReturn "$handler" buildHome) || return $?

  directory="${directory#./}"
  directory="${directory#/}"
  directory="${directory%/}"
  [ -d "${home%/}/$directory" ] || throwArgument "$handler" "$2 element #$index is not a directory $(decorate code "$home/$directory"): $(decorate value "$3")" || return $?
  printf "%s\n" "$directory"
}

# Validates a value as an application-relative file. Upon success, outputs relative path.
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Value to test.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `directory list`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentApplicationFile() {
  local handler="$1" args
  args=("$@")
  args[3]="${4-}"
  [ ${#args[@]} -eq 4 ] || throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?

  local file="$3"
  [ -n "$file" ] || throwArgument "$handler" "$directory is blank" || return $?

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  file="${file#./}"
  file="${file#/}"
  local appFile="${home%/}/$file"
  [ -f "$appFile" ] || throwArgument "$handler" "$2 element #$index is not a file $(decorate code "$appFile"): $(decorate value "$file")" || return $?
  printf "%s\n" "$file"
}

# Validates a value is not blank and is a directory and does `realPath` on it.
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `directory`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentRealDirectory() {
  local handler="$1" args directory
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
  fi

  args[2]=$(realPath "${args[2]}") || throwArgument "$handler" "realPath" "${args[2]}" || return $?
  directory="$(__catchArgumentHelper "directory" "${args[@]}" test -d)" || return $?
  printf "%s\n" "${directory%/}"
}

# Validates a value is not blank and is a file path with a directory that exists. Upon success, outputs the file name.
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `file`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentFileDirectory() {
  local args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "file" "${args[@]}" fileDirectoryExists || return $?
}

#
# Do not require argument to be non-blank
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Argument: value - Optional. String, Value to output.
# Return Code: 0 - Always
usageArgumentEmptyString() {
  local handler="$1" argument="$2"
  shift 2 || :
  printf "%s\n" "${1-}"
}

# Require an argument to be a boolean value
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be non-blank otherwise an argument error is thrown.
# Return Code: 2 - If `value` is not a boolean
# Return Code: 0 - If `value` is a boolean
usageArgumentBoolean() {
  local handler="$1" argument="$2"
  shift 2 || :
  isBoolean "${1-}" || throwArgument "$handler" "$argument not boolean: \"${1-}\"" || return $?
  printf "%s\n" "$1"
}

# Require an argument to be a URL
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be a URL otherwise an argument error is thrown.
# Return Code: 0 - If `value` is `urlValid`
# Return Code: 2 - If `value` is not `urlValid`
usageArgumentURL() {
  local handler="$1" argument="$2"
  shift 2 || :
  urlValid "${1-}" || throwArgument "$handler" "$argument \"${1-}\" is not a valid URL" || return $?
  printf "%s\n" "$1"
}

# Require an argument to be a callable
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be callable otherwise an argument error is thrown.
# Return Code: 2 - If `value` is not `isCallable`
# Return Code: 0 - If `value` is `isCallable`
usageArgumentCallable() {
  local handler="$1" argument="$2"
  shift 2 || :
  isCallable "${1-}" || throwArgument "$handler" "$argument \"${1-}\" is not callable" || return $?
  printf "%s\n" "$1"
}

# Require an argument to be a executable
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be executable otherwise an argument error is thrown.
# Return Code: 2 - If `value` is not `isExecutable`
# Return Code: 0 - If `value` is `isExecutable`
usageArgumentExecutable() {
  local handler="$1" argument="$2"
  shift 2 || :
  isExecutable "${1-}" || throwArgument "$handler" "$argument \"${1-}\" is not executable" || return $?
  printf "%s\n" "$1"
}

# Require an argument to be a function
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be a function otherwise an argument error is thrown.
# Return Code: 2 - If `value` is not `isFunction`
# Return Code: 0 - If `value` is `isFunction`
usageArgumentFunction() {
  local handler="$1" argument="$2"
  shift 2 || :
  isFunction "${1-}" || throwArgument "$handler" "$argument \"${1-}\" is not a function" || return $?
  printf "%s\n" "$1"
}

# Validates a value is ok for an environment variable name
# Upon success, outputs the name
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Environment variable name.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `environment variable`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentEnvironmentVariable() {
  local handler="$1" argument="$2"
  shift 2 || :
  environmentVariableNameValid "${1-}" || throwArgument "$handler" "$argument \"${1-}\" is not a valid environment variable name" || return $?
  printf "%s\n" "$1"
}

# Secrets are things which should be kept secret
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
usageArgumentSecret() {
  usageArgumentString "$@" || return $?
}

# List delimited with commas `,`
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
usageArgumentCommaDelimitedList() {
  usageArgumentEmptyString "$@" || return $?
}

# List delimited with colons `:`
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
usageArgumentColonDelimitedList() {
  usageArgumentEmptyString "$@" || return $?
}

# List delimited with colons `:`
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
usageArgumentFlag() {
  usageArgumentEmptyString "$@" || return $?
}

# List delimited with spaces ` `
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
usageArgumentList() {
  usageArgumentEmptyString "$@" || return $?
}

# Placeholder for array types
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
usageArgumentArray() {
  usageArgumentEmptyString "$@" || return $?
}

# Placeholder for additional arguments
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Argument: value ... - Arguments. Optional.Additional arguments.
usageArgumentArguments() {
  usageArgumentEmptyString "$@" || return $?
}

# A remote path is one which exists in another file system
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Return Code: 2 - Always
usageArgumentRemoteDirectory() {
  local handler="$1" argument="$2"
  shift 2 || :
  local path="${1-}"
  [ "${path:0:1}" = "/" ] || throwArgument "$handler" "$argument \"${1-}\" is not a valid remote path" || return $?
  printf "%s\n" "${1%/}"
}

# A remote path is one which exists in another file system
# Argument: handler - Function. Required. handler function to call upon failure.
# Argument: argument - String. Required. Name of the argument used in error messages.
# Return Code: 2 - Always
usageArgumentDate() {
  local handler="$1" argument="$2"
  shift 2 || :
  dateValid "${1-}" || throwArgument "$handler" "$argument \"${1-}\" is not a valid date" || return $?
  printf "%s\n" "$1"
}
