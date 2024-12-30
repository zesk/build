#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh
# Docs: o ./docs/_templates/tools/usage.md

###############################################################################
#
# ▐▌ ▐▌▗▟██▖ ▟██▖ ▟█▟▌ ▟█▙
# ▐▌ ▐▌▐▙▄▖▘ ▘▄▟▌▐▛ ▜▌▐▙▄▟▌
# ▐▌ ▐▌ ▀▀█▖▗█▀▜▌▐▌ ▐▌▐▛▀▀▘
# ▐▙▄█▌▐▄▄▟▌▐▙▄█▌▝█▄█▌▝█▄▄▌
#  ▀▀▝▘ ▀▀▀  ▀▀▝▘ ▞▀▐▌ ▝▀▀
#              ▜█▛▘
#------------------------------------------------------------------------------
#

#
# Usage: usageTemplate binName options delimiter description exitCode message ...
#
# Output usage messages to console
#
# Should look into an actual file template, probably
# See: usageDocument
#
# Do not call usage functions here to avoid recursion
#
usageTemplate() {
  local this="${FUNCNAME[0]}"
  local usageString binName options delimiter description exitCode

  [ $# -ge 5 ] || _argument "$(printf -- "%s %s %s" "$(decorate error "$this")" "$(decorate code "$(printf -- " \"%s\"" "$@")")" "$(decorate error "missing arguments - passed $# need 5")")" || return $?
  binName="$(trimSpace "$1")"
  options="$2"
  delimiter="$3"
  description="$4"
  exitCode="${5-0}"
  isInteger "$exitCode" || _argument "$(printf "%s: exit code is not integer \"%s\"\n%s" "$this" "$exitCode" "$(debuggingStack)")" || return $?
  if [ "$exitCode" -eq 0 ]; then
    usageString="$(decorate bold-green Usage)"
  else
    usageString="$(decorate bold-red Usage)"
  fi
  shift 5 || _argument "$this: shift 5" || return $?
  if [ ${#@} -gt 0 ]; then
    if [ "$exitCode" -eq 0 ]; then
      printf "%s\n\n" "$(decorate success "$@")"
    elif [ "$exitCode" != "$(_code argument)" ]; then
      printf "%s (-> %s)\n" "$(decorate error "$@")" "$(decorate code " $exitCode ")"
      return "$exitCode"
    else
      printf "%s (-> %s)\n\n" "$(decorate error "$@")" "$(decorate code " $exitCode ")"
    fi
  fi
  description=${description:-"No description"}
  nSpaces=$(printf %s "$options" | maximumFieldLength 1 "$delimiter")

  if [ -n "$delimiter" ] && [ -n "$options" ]; then
    printf -- "%s: %s%s\n\n%s\n\n%s\n" \
      "$usageString" \
      "$(decorate info "$binName")" \
      "$(printf "%s" "$options" | usageArguments "$delimiter")" \
      "$(printf "%s" "$options" | usageGenerator "$((nSpaces + 2))" "$delimiter" | wrapLines "    " "$(decorate reset)")" \
      "$description"
  else
    printf "%s: %s\n\n%s\n\n" \
      "$usageString" \
      "$(decorate info "$binName")" \
      "$description"
  fi
  if buildDebugEnabled usage; then
    debuggingStack
  fi
  return "$exitCode"
}

# Parses input stream and generates an argument documentation list
# Input is in the format with "{argument}{delimiter}{description}{newline}" and generates a list of arguments color coded based
# on whether the word "require" appears in the description.
#
# Usage: usageArguments delimiter
# Argument: delimiter - Required. String. The character to separate name value pairs in the input
usageArguments() {
  local separatorChar="${1-" "}" requiredPrefix optionalPrefix argument lineTokens argDescription lastLine

  optionalPrefix=${2-"$(decorate blue)"}
  requiredPrefix=${3-"$(decorate red)"}

  lineTokens=()
  lastLine=
  while true; do
    if ! IFS="$separatorChar" read -r -a lineTokens; then
      lastLine=1
    fi
    if [ ${#lineTokens[@]} -gt 0 ]; then
      argument="${lineTokens[0]}"
      # printf "lineTokens-0: %s\n" "${lineTokens[@]}"
      unset "lineTokens[0]"
      # printf "lineTokens-1: %s\n" "${lineTokens[@]}"
      lineTokens=("${lineTokens[@]+${lineTokens[@]}}")
      # printf "lineTokens-2: %s\n" "${lineTokens[@]}"
      argDescription=$(lowercase "${lineTokens[*]-}")
      # printf "argDescription: %s\n" "$argDescription"
      if [ "${argDescription%*require*}" != "$argDescription" ]; then
        printf " %s%s" "$requiredPrefix" "$argument"
      else
        printf " %s[ %s ]" "$optionalPrefix" "$argument"
      fi
    fi
    if test $lastLine; then
      break
    fi
  done
}

# Formats name value pairs separated by separatorChar (default " ") and uses
# $nSpaces width for first field
#
# usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile
#
# use with maximumFieldLength 1 to generate widths
#
# Argument: nSpaces - Required. Integer. Number of spaces to indent arguments.
# Argument: separatorChar - Optional. String. Default is space.
# Argument: labelPrefix - Optional. String. Defaults to blue color text.
# Argument: valuePrefix - Optional. String. Defaults to red color text.
#
usageGenerator() {
  local nSpaces=$((${1-30} + 0)) separatorChar=${2-" "} labelPrefix valuePrefix labelOptionalPrefix labelRequiredPrefix capsLine lastLine

  labelOptionalPrefix=${3-"$(decorate blue)"}
  labelRequiredPrefix=${4-"$(decorate red)"}
  # shellcheck disable=SC2119
  valuePrefix=${5-"$(decorate value)"}
  lastLine=
  blankLine=false

  while true; do
    if ! IFS= read -r line; then
      lastLine=1
    fi
    if [ -z "$(trimSpace "$line")" ]; then
      blankLine=true
    else
      capsLine="$(lowercase "$line")"
      if [ "${capsLine##*required}" != "$capsLine" ]; then
        labelPrefix=$labelRequiredPrefix
      else
        labelPrefix=$labelOptionalPrefix
      fi
      if $blankLine; then
        printf "\n"
        blankLine=false
      fi
      printf "%s\n" "$line" | awk "-F$separatorChar" "{ print \"$labelPrefix\" sprintf(\"%-\" $nSpaces \"s\", \$1) \"$valuePrefix\" substr(\$0, index(\$0, \"$separatorChar\") + 1) }"
    fi
    if test $lastLine; then
      break
    fi
  done | simpleMarkdownToConsole | trimTail
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
  local usage="${1-}"
  if [ "$(type -t "$usage")" != "function" ]; then
    _argument "$(decorate code "$usage") must be a valid function" || return $?
  fi
  shift
  local binary
  for binary in "$@"; do
    if [ -z "$(which "$binary" || :)" ]; then
      __failEnvironment "$usage" "$binary is not available in path, not found: $(decorate code "$PATH")"
    fi
  done
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
  local usage
  usage="${1-}"
  if [ "$(type -t "$usage")" != "function" ]; then
    _argument "$(decorate code "$usage") must be a valid function" || return $?
  fi
  shift
  local environmentVariable
  for environmentVariable in "$@"; do
    if [ -z "${!environmentVariable-}" ]; then
      __failEnvironment "$usage" "Environment variable $(decorate code "$environmentVariable") is required" || return $?
    fi
  done
}

# Arguments: defaultNoun - Required. String. Default noun if user noun is empty
# Arguments: usageFunction - Required. Function. Error handler
# Arguments: variableName - Required. String. Name to test
# Arguments: variableValue - Required. EmptyString. Value to test
# Arguments: noun - Required. EmptyString. Noun passed by user
# Arguments: testCommand ... - Required. Callable. Test command to run on value.
# Utility function to handle all usage
#
__usageArgumentHelper() {
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
  [ -n "$variableValue" ] || __failArgument "$usageFunction" "$variableName $noun is required" || return $?

  # Remaining parameters are the test
  "$@" "$variableValue" || __failArgument "$usageFunction" "$variableName is not $noun (\"$(decorate code "$variableValue")$(decorate error '")')" || return $?

  printf "%s\n" "$variableValue"
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
  [ ${#args[@]} -eq 4 ] || __failArgument "$usage" "Need 4 arguments" || return $?
  __usageArgumentHelper integer "${args[@]}" isInteger
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
    __failArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments"
    return $?
  fi
  __usageArgumentHelper "unsigned integer" "${args[@]}" isUnsignedInteger
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
    __failArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments"
    return $?
  fi
  __usageArgumentHelper "positive integer" "${args[@]}" isUnsignedInteger >/dev/null && __usageArgumentHelper "positive integer" "${args[@]}" test 0 -lt || return $?
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
    __failArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments"
    return $?
  fi
  __usageArgumentHelper "file" "${args[@]}" test -f
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
    __failArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments"
    return $?
  fi
  __usageArgumentHelper "link" "${args[@]}" test -L
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
    __failArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments"
    return $?
  fi
  directory="$(__usageArgumentHelper "directory" "${args[@]}" test -d)" || return $?
  printf "%s\n" "${directory%/}"
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
    __failArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments" || return $?
  fi

  args[2]=$(realPath "${args[2]}") || __failArgument "$usage" "realPath" "${args[2]}" || return $?
  directory="$(__usageArgumentHelper "directory" "${args[@]}" test -d)" || return $?
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
    __failArgument "$usage" "${FUNCNAME[0]} Need at least 3 arguments"
    return $?
  fi
  __usageArgumentHelper "file" "${args[@]}" fileDirectoryExists
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
  bashEnv=$(__usageEnvironment "$usageFunction" mktemp) || return $?
  __usageEnvironment "$usageFunction" anyEnvToBashEnv "$envFile" >"$bashEnv" || _clean $? "$bashEnv" || return $?
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
  [ -n "${1-}" ] || __failArgument "$usage" "blank" "$argument" || return $?
  printf "%s\n" "$1"
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
  isBoolean "${1-}" || __failArgument "$usage" "$argument not boolean: \"${1-}\"" || return $?
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
  urlValid "${1-}" || __failArgument "$usage" "$argument \"${1-}\" is not a valid URL" || return $?
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
  isCallable "${1-}" || __failArgument "$usage" "$argument \"${1-}\" is not callable" || return $?
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
  isExecutable "${1-}" || __failArgument "$usage" "$argument \"${1-}\" is not executable" || return $?
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
  isFunction "${1-}" || __failArgument "$usage" "$argument \"${1-}\" is not a function" || return $?
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
  environmentVariableNameValid "${1-}" || __failArgument "$usage" "$argument \"${1-}\" is not a valid environment variable name" || return $?
  printf "%s\n" "$1"
}

# Throw an unknown argument error
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentUnknown() {
  local usage="$1" argument="$2"
  shift 2 || :
  __failArgument "$usage" "unknown argument: $(decorate value "$argument")" "$@" || return $?
}

# Throw an missing argument error
# Usage: {fn} usage argument
# Argument: usage - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Exit Code: 2 - Always
usageArgumentMissing() {
  local usage="$1" argument="$2"
  shift 2 || :
  __failArgument "$usage" "missing argument $(decorate label "$argument")" "$@" || return $?
}
