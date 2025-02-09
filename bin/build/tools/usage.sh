#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# usage - argument checking code
#
# Test: ./test/tools/usage-tests.sh
# Docs: ./docs/_templates/tools/usage.md

# Throw an unknown argument error
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentUnknown() {
  local usage="$1" argument="$2"
  shift 2 || :
  __throwArgument "$usage" "unknown argument: $(decorate value "$argument")" "$@" || return $?
}

#
# Summary: Check that one or more binaries are installed
# Usage: {fn} usage binary0 [ ... ]
# Argument: usageFunction - Required. `bash` function already defined to output usage
# Argument: binary0 - Required. Binary which must have a `which` path.
# Exit Codes: 1 - If any binary0 are not available within the current path
# Requires the binaries to be found via `which`
#
# Runs `usage` on failure
#
usageRequireBinary() {
  # IDENTICAL usageFunctionHeader 4
  local usage="_${FUNCNAME[0]}" usageFunction="${1-}" && shift
  if [ "$(type -t "$usage")" != "function" ]; then
    __catchArgument "$usage" "$(decorate code "$usage") must be a valid function" || return $?
  fi
  local binary
  for binary in "$@"; do
    whichExists "$binary" || __throwEnvironment "$usage" "$binary is not available in path, not found: $(decorate code "$PATH")"
  done
}
_usageRequireBinary() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} usage [ env0 ... ]
# Requires environment variables to be set and non-blank
# Argument: usageFunction - Required. `bash` function already defined to output usage
# Argument: env0 - Optional. String. One or more environment variables which should be set and non-empty.
# Exit Codes: 1 - If any env0 variables bre not set or bre empty.
# Deprecated: 2024-01-01
#
usageRequireEnvironment() {
  # IDENTICAL usageFunctionHeader 4
  local usage="_${FUNCNAME[0]}" usageFunction="${1-}" && shift
  if [ "$(type -t "$usage")" != "function" ]; then
    __catchArgument "$usage" "$(decorate code "$usage") must be a valid function" || return $?
  fi
  local environmentVariable
  for environmentVariable in "$@"; do
    if [ -z "${!environmentVariable-}" ]; then
      __throwEnvironment "$usageFunction" "Environment variable $(decorate code "$environmentVariable") is required" || return $?
    fi
  done
}
_usageRequireEnvironment() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Arguments: defaultNoun - Required. String. Default noun if user noun is empty
# Arguments: usageFunction - Required. Function. Error handler
# Arguments: variableName - Required. String. Name to test
# Arguments: variableValue - Required. EmptyString. Value to test
# Arguments: noun - Required. EmptyString. Noun passed by user
# Arguments: testCommand ... - Required. Callable. Test command to run on value.
# Utility function to handle all usage
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
  [ -n "$variableValue" ] || __throwArgument "$usageFunction" "$variableName $noun is required ($(decorate code "$variableValue"))" || return $?

  # Remaining parameters are the test
  "$@" "$variableValue" || __throwArgument "$usageFunction" "$variableName is not $noun (\"$(decorate code "$variableValue")$(decorate error '")')" || return $?

  printf "%s\n" "$variableValue"
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

# Validates a value is an integer
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `integer`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentInteger() {
  local args usage="$1"
  args=("$@")
  args[3]="${4-}"
  [ ${#args[@]} -eq 4 ] || __throwArgument "$usage" "Need 4 arguments" || return $?
  __catchArgumentHelper integer "${args[@]}" isInteger || return $?
}

# Validates a value is an unsigned integer
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `unsigned integer`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentUnsignedInteger() {
  local usage="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "unsigned integer" "${args[@]}" isUnsignedInteger || return $?
}

# Validates a value is an unsigned integer and greater than zero (NOT zero)
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `unsigned integer`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentPositiveInteger() {
  local usage="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "positive integer" "${args[@]}" isUnsignedInteger >/dev/null && __catchArgumentHelper "positive integer" "${args[@]}" test 0 -lt || return $?
}

# Validates a value is not blank and is a file.
# Upon success, outputs the file name
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentFile() {
  local usage="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "file" "${args[@]}" test -f || return $?
}

# Validates a value is not blank and exists in the file system
# Upon success, outputs the file name
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file or directory`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentExists() {
  local usage="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "file or directory" "${args[@]}" test -e || return $?
}

# Validates a value is not blank and is a link
# Upon success, outputs the file name
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Path to a link file.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `link`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentLink() {
  local usage="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "link" "${args[@]}" test -L || return $?
}

# Validates a value is not blank and is a directory. Upon success, outputs the directory name trailing slash stripped.
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentDirectory() {
  local usage="$1" args directory
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  directory="$(__catchArgumentHelper "directory" "${args[@]}" test -d)" || return $?
  printf "%s\n" "${directory%/}"
}

# Validates a value as a directory search list. Upon success, outputs the entire list, cleans up any invalid values or trailing characters.
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory list`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentDirectoryList() {
  local usage="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  local directories=() directory result=() index=0
  IFS=":" read -r -a directories <<<"$3" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    [ -n "$directory" ] || continue
    [ -d "$directory" ] || __throwArgument "$2 element #$index is not a directory $(decorate code "$directory"): $(decorate value "$3")" || return $?
    result+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${result[@]+"${result[@]}"}")"
}

# Validates a value as an application-relative directory search list. Upon success, outputs the entire list, cleans up any invalid values or trailing characters.
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory list`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentApplicationDirectoryList() {
  local usage="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi

  local home directories=() directory result=() index=0

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  IFS=":" read -r -a directories <<<"$3" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    [ -n "$directory" ] || continue
    directory="${directory#./}"
    directory="${directory#/}"
    directory="${directory%/}"
    [ -d "${home%/}/$directory" ] || __throwArgument "$2 element #$index is not a directory $(decorate code "$home/$directory"): $(decorate value "$3")" || return $?
    result+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${result[@]+"${result[@]}"}")"
}

# Validates a value as an application-relative directory. Upon success, outputs the full path.
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory list`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentApplicationDirectory() {
  local usage="$1" args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  local home directory="$3"

  [ -z "$directory" ] || __throwArgument "$usage" "$2 is blank" || return $?
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  directory="${directory#./}"
  directory="${directory#/}"
  directory="${directory%/}"
  [ -d "${home%/}/$directory" ] || __throwArgument "$2 element #$index is not a directory $(decorate code "$home/$directory"): $(decorate value "$3")" || return $?
  printf "%s\n" "${home%/}/$directory"
}

# Validates a value is not blank and is a directory and does `realPath` on it.
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentRealDirectory() {
  local usage="$1" args directory
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
  fi

  args[2]=$(realPath "${args[2]}") || __throwArgument "$usage" "realPath" "${args[2]}" || return $?
  directory="$(__catchArgumentHelper "directory" "${args[@]}" test -d)" || return $?
  printf "%s\n" "${directory%/}"
}

# Validates a value is not blank and is a file path with a directory that exists. Upon success, outputs the file name.
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentFileDirectory() {
  local args
  args=("$@")
  args[3]="${4-}"
  if [ ${#args[@]} -ne 4 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
    return $?
  fi
  __catchArgumentHelper "file" "${args[@]}" fileDirectoryExists || return $?
}

# Validates a value is not blank and is an environment file which is loaded immediately.
#
# Usage: {fn} processPid usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
# Upon success, outputs the file name to stdout, outputs a console message to stderr
usageArgumentLoadEnvironmentFile() {
  local envFile bashEnv usageFunction returnCode

  usageFunction="$1"
  envFile=$(usageArgumentFile "$@") || return $?
  bashEnv=$(__catchEnvironment "$usageFunction" mktemp) || return $?
  __catchEnvironment "$usageFunction" anyEnvToBashEnv "$envFile" >"$bashEnv" || _clean $? "$bashEnv" || return $?
  set -a
  # shellcheck source=/dev/null
  source "$bashEnv"
  returnCode=$?
  set +a
  rm -f "$bashEnv" || :
  if [ $returnCode -ne 0 ]; then
    "$usageFunction" "$returnCode" "source $envFile -> $bashEnv failed" || return $?
  fi
  printf "%s\n" "$envFile"
}

#
# Do not require argument to be non-blank
# Usage: {fn} usage argument [ value ]
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value to output.
# Exit code: 0 - Always
usageArgumentEmptyString() {
  local usage="$1" argument="$2"
  shift 2 || :
  printf "%s\n" "${1-}"
}

# Require an argument to be a boolean value
# Usage: {fn} usage argument [ value ]
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be non-blank otherwise an argument error is thrown.
# Exit Code: 2 - If `value` is not a boolean
# Exit code: 0 - If `value` is a boolean
usageArgumentBoolean() {
  local usage="$1" argument="$2"
  shift 2 || :
  isBoolean "${1-}" || __throwArgument "$usage" "$argument not boolean: \"${1-}\"" || return $?
  printf "%s\n" "$1"
}

# Require an argument to be a URL
# Usage: {fn} usage argument [ value ]
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be a URL otherwise an argument error is thrown.
# Exit code: 0 - If `value` is `urlValid`
# Exit Code: 2 - If `value` is not `urlValid`
usageArgumentURL() {
  local usage="$1" argument="$2"
  shift 2 || :
  urlValid "${1-}" || __throwArgument "$usage" "$argument \"${1-}\" is not a valid URL" || return $?
  printf "%s\n" "$1"
}

# Require an argument to be a callable
# Usage: {fn} usage argument [ value ]
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be callable otherwise an argument error is thrown.
# Exit Code: 2 - If `value` is not `isCallable`
# Exit code: 0 - If `value` is `isCallable`
usageArgumentCallable() {
  local usage="$1" argument="$2"
  shift 2 || :
  isCallable "${1-}" || __throwArgument "$usage" "$argument \"${1-}\" is not callable" || return $?
  printf "%s\n" "$1"
}

# Require an argument to be a executable
# Usage: {fn} usage argument [ value ]
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be executable otherwise an argument error is thrown.
# Exit Code: 2 - If `value` is not `isExecutable`
# Exit code: 0 - If `value` is `isExecutable`
usageArgumentExecutable() {
  local usage="$1" argument="$2"
  shift 2 || :
  isExecutable "${1-}" || __throwArgument "$usage" "$argument \"${1-}\" is not executable" || return $?
  printf "%s\n" "$1"
}

# Require an argument to be a function
# Usage: {fn} usage argument [ value ]
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be a function otherwise an argument error is thrown.
# Exit Code: 2 - If `value` is not `isFunction`
# Exit code: 0 - If `value` is `isFunction`
usageArgumentFunction() {
  local usage="$1" argument="$2"
  shift 2 || :
  isFunction "${1-}" || __throwArgument "$usage" "$argument \"${1-}\" is not a function" || return $?
  printf "%s\n" "$1"
}

# Validates a value is ok for an environment variable name
# Upon success, outputs the name
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Environment variable name.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `environment variable`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
usageArgumentEnvironmentVariable() {
  local usage="$1" argument="$2"
  shift 2 || :
  environmentVariableNameValid "${1-}" || __throwArgument "$usage" "$argument \"${1-}\" is not a valid environment variable name" || return $?
  printf "%s\n" "$1"
}

# Throw an missing argument error
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentMissing() {
  local usage="$1" argument="$2"
  shift 2 || :
  __throwArgument "$usage" "missing argument $(decorate label "$argument")" "$@" || return $?
}

# Secrets are things which should be kept secret
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentSecret() {
  usageArgumentString "$@"
}

# List delimited with commas `,`
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentCommaDelimitedList() {
  usageArgumentEmptyString "$@"
}

# List delimited with colons `:`
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentColonDelimitedList() {
  usageArgumentEmptyString "$@"
}

# List delimited with spaces ` `
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentList() {
  usageArgumentEmptyString "$@"
}

# Placeholder for array types
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentArray() {
  usageArgumentEmptyString "$@"
}

# A remote path is one which exists in another file system
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentRemoteDirectory() {
  local usage="$1" argument="$2"
  shift 2 || :
  local path="${1-}"
  [ "${path:0:1}" = "/" ] || __throwArgument "$usage" "$argument \"${1-}\" is not a valid remote path" || return $?
  printf "%s\n" "$1"
}

# A remote path is one which exists in another file system
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentDate() {
  local usage="$1" argument="$2"
  shift 2 || :
  dateValid "${1-}" || __throwArgument "$usage" "$argument \"${1-}\" is not a valid date" || return $?
  printf "%s\n" "$1"
}
