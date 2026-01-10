#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# handler - argument checking code
#
# Test: ./test/tools/handler-tests.sh
# Docs: ./documentation/source/tools/handler.md

#   _   _ ___  __ _  __ _  ___
#  | | | / __|/ _` |/ _` |/ _ \
#  | |_| \__ \ (_| | (_| |  __/
#   \__,_|___/\__,_|\__, |\___|
#                   |___/

# Argument: handler - Function. Required. Error handler.
# Argument: function - Function. Required. Function to call; first argument will be `handler`.
# Argument ... - Arguments. Optional. Additional arguments to the function.
__usageLoader() {
  __buildFunctionLoader __usageDocument usage "$@"
}

# Summary: Universal error handler for functions (with formatting)
#
# Actual function is called `{functionName}`.
#
# Argument: functionDefinitionFile - Required. File. The file in which the function is defined. If you don't know, use `__bashDocumentation_FindFunctionDefinitions` or `__bashDocumentation_FindFunctionDefinition`.
# Argument: functionName - Required. String. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
# Argument: exitCode - Required. Integer. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
# Argument: message - Optional. String. A message.
#
# Generates console usage output for a script using documentation tools parsed from the comment of the function identified.
#
# Simplifies documentation and keeps it with the code.
#
# Environment: *BUILD_DEBUG* - Add `fast-usage` to make this quicker when you do not care about usage/failure.
# BUILD_DEBUG: fast-usage - `usageDocument` does not output formatted help for performance reasons
# BUILD_DEBUG: handler - For all `--help` and any function which uses `usageTemplate` to output documentation (upon error), the stack will be displayed
usageDocument() {
  #  usageDocumentSimple "$@"
  __usageLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_usageDocument() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL usageDocumentSimple 33

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - Optional. String. Message to display to the user.
# Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument
usageDocumentSimple() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" color helpColor="info" icon="❌" line prefix="" finished=false skip=false && shift 3

  case "$returnCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="bold-red" ;; *) color="orange" ;; esac
  [ "$returnCode" -eq 0 ] || exec 1>&2
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(returnCodeString "$returnCode")")" "$(decorate "$color" "$*")"
  if [ ! -f "$source" ]; then
    export BUILD_HOME
    [ -d "${BUILD_HOME-}" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
    source="$BUILD_HOME/$source"
    [ -f "$source" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
  fi
  while ! $finished; do
    IFS='' read -r line || finished=true
    printf "%s%s\n" "$prefix" "$(decorate "$helpColor" "$line")"
    prefix=""
  done < <(bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g")
  return "$returnCode"
}
_usageDocumentSimple() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Check that one or more binaries are installed
# Argument: usageFunction - Required. `bash` function already defined to output handler
# Argument: binary - Required. Binary which must have a `which` path.
# Return Code: 1 - If any `binary` is not available within the current path
# Requires the binaries to be found via `which`
#
# Runs `handler` on failure
#
usageRequireBinary() {
  # IDENTICAL usageFunctionHeader 6
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local usageFunction="${1-}" && shift
  if [ "$(type -t "$usageFunction")" != "function" ]; then
    catchArgument "$handler" "$(decorate code "$handler") must be a valid function" || return $?
  fi
  local binary
  for binary in "$@"; do
    whichExists "$binary" || throwEnvironment "$handler" "$binary is not available in path, not found: $(decorate code "$PATH")"
  done
}
_usageRequireBinary() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Requires environment variables to be set and non-blank
# Argument: usageFunction - Required. `bash` function already defined to output handler
# Argument: environmentVariable - Optional. String. One or more environment variables which should be set and non-empty.
# Return Code: 0 - All environment variables are set and non-empty
# Return Code: 1 - If any `environmentVariable` variables are not set or are empty.
# Deprecated: 2024-01-01
#
usageRequireEnvironment() {
  # IDENTICAL usageFunctionHeader 6
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local usageFunction="${1-}" && shift
  if [ "$(type -t "$usageFunction")" != "function" ]; then
    catchArgument "$handler" "$(decorate code "$handler") must be a valid function" || return $?
  fi
  local environmentVariable
  for environmentVariable in "$@"; do
    if [ -z "${!environmentVariable-}" ]; then
      throwEnvironment "$usageFunction" "Environment variable $(decorate code "$environmentVariable") is required" || return $?
    fi
  done
}
_usageRequireEnvironment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: defaultNoun - Required. String. Default noun if user noun is empty
# Argument: usageFunction - Required. Function. Error handler
# Argument: variableName - Required. String. Name to test
# Argument: variableValue - Required. EmptyString. Value to test
# Argument: noun - Required. EmptyString. Noun passed by user
# Argument: testCommand ... - Required. Callable. Test command to run on value.
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

# IDENTICAL usageArgumentCore 14

# Require an argument to be non-blank
# Argument: handler - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
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

# IDENTICAL usageArgumentPositiveInteger 14

# Validates a value is an positive integer and greater than zero (NOT zero)
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `unsigned integer`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `integer`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `integer`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Value to test.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Value to test.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file or directory`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Path to a link file.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `link`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory list`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory list`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory list`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Value to test.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory list`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory`
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
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

# Validates a value is not blank and is an environment file which is loaded immediately.
#
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
# Upon success, outputs the file name to stdout, outputs a console message to stderr
usageArgumentLoadEnvironmentFile() {
  local envFile bashEnv usageFunction returnCode

  usageFunction="$1"
  envFile=$(usageArgumentFile "$@") || return $?
  bashEnv=$(fileTemporaryName "$usageFunction") || return $?
  catchEnvironment "$usageFunction" environmentFileToBashCompatible "$envFile" >"$bashEnv" || returnClean $? "$bashEnv" || return $?
  set -a # UNDO ok
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
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value to output.
# Return Code: 0 - Always
usageArgumentEmptyString() {
  local handler="$1" argument="$2"
  shift 2 || :
  printf "%s\n" "${1-}"
}

# Require an argument to be a boolean value
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
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
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
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
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
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
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
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
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
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
# Argument: usageFunction - Required. Function. Run if handler fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Environment variable name.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `environment variable`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
usageArgumentEnvironmentVariable() {
  local handler="$1" argument="$2"
  shift 2 || :
  environmentVariableNameValid "${1-}" || throwArgument "$handler" "$argument \"${1-}\" is not a valid environment variable name" || return $?
  printf "%s\n" "$1"
}

# Secrets are things which should be kept secret
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
usageArgumentSecret() {
  usageArgumentString "$@" || return $?
}

# List delimited with commas `,`
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
usageArgumentCommaDelimitedList() {
  usageArgumentEmptyString "$@" || return $?
}

# List delimited with colons `:`
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
usageArgumentColonDelimitedList() {
  usageArgumentEmptyString "$@" || return $?
}

# List delimited with colons `:`
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
usageArgumentFlag() {
  usageArgumentEmptyString "$@" || return $?
}

# List delimited with spaces ` `
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
usageArgumentList() {
  usageArgumentEmptyString "$@" || return $?
}

# Placeholder for array types
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
usageArgumentArray() {
  usageArgumentEmptyString "$@" || return $?
}

# Placeholder for additional arguments
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value ... - Optional. Arguments. Additional arguments.
usageArgumentArguments() {
  usageArgumentEmptyString "$@" || return $?
}

# A remote path is one which exists in another file system
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Return Code: 2 - Always
usageArgumentRemoteDirectory() {
  local handler="$1" argument="$2"
  shift 2 || :
  local path="${1-}"
  [ "${path:0:1}" = "/" ] || throwArgument "$handler" "$argument \"${1-}\" is not a valid remote path" || return $?
  printf "%s\n" "${1%/}"
}

# A remote path is one which exists in another file system
# Argument: handler - Required. Function. handler function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Return Code: 2 - Always
usageArgumentDate() {
  local handler="$1" argument="$2"
  shift 2 || :
  dateValid "${1-}" || throwArgument "$handler" "$argument \"${1-}\" is not a valid date" || return $?
  printf "%s\n" "$1"
}
