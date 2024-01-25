#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh
# Docs: o ./docs/_templates/tools/usage.md

# IDENTICAL errorArgument 1
errorArgument=2

# IDENTICAL errorEnvironment 1
errorEnvironment=1

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
# Usage: usageTemplate binName options delimiter description exitCode message
#
# Output usage messages to console
#
# Should look into an actual file template, probably
# See: usageDocument
#
usageTemplate() {
  local usageString binName options delimiter description exitCode

  binName="$1"
  shift || return "$errorArgument"
  options="$(printf "%s\n" "$1")"
  shift || return "$errorArgument"
  delimiter="$1"
  shift || return "$errorArgument"
  description="$1"
  shift || return "$errorArgument"
  exitCode="${1-0}"
  usageString="$(consoleBoldRed Usage)"
  shift || :

  exec 1>&2
  if [ ${#@} -gt 0 ]; then
    consoleError "$@"
    echo
  fi
  description=${description:-"No description"}
  nSpaces=$(printf %s "$options" | maximumFieldLength 1 "$delimiter")

  if [ -n "$delimiter" ] && [ -n "$options" ]; then
    printf "%s: %s%s\n\n%s\n\n%s\n\n" \
      "$usageString" \
      "$(consoleInfo -n "$binName")" \
      "$(printf %s "$options" | usageArguments "$delimiter")" \
      "$(printf %s "$options" | usageGenerator "$((nSpaces + 2))" "$delimiter" | prefixLines "    ")" \
      "$(consoleReset)$description"
  else
    printf "%s: %s\n\n%s\n\n" \
      "$usageString" \
      "$(consoleInfo "$binName")" \
      "$(consoleReset)$description"
    echo
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

  optionalPrefix=${2-"$(consoleBlue)"}
  requiredPrefix=${3-"$(consoleRed)"}

  lineTokens=()
  lastLine=
  while true; do
    if ! IFS="$separatorChar" read -r -a lineTokens; then
      lastLine=1
    fi
    if [ ${#lineTokens[@]} -gt 0 ]; then
      argument="${lineTokens[0]}"
      unset "lineTokens[0]"
      lineTokens=("${lineTokens[@]}")
      argDescription=$(lowercase "${lineTokens[*]}")
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

  labelOptionalPrefix=${3-"$(consoleBlue)"}
  labelRequiredPrefix=${4-"$(consoleRed)"}
  # shellcheck disable=SC2119
  valuePrefix=${5-"$(consoleValue)"}
  lastLine=

  while true; do
    if ! IFS= read -r line; then
      lastLine=1
    fi
    capsLine="$(lowercase "$line")"
    if [ "${capsLine##*required}" != "$capsLine" ]; then
      labelPrefix=$labelRequiredPrefix
    else
      labelPrefix=$labelOptionalPrefix
    fi
    printf "%s\n" "$line" | awk "-F$separatorChar" "{ print \"$labelPrefix\" sprintf(\"%-\" $nSpaces \"s\", \$1) \"$valuePrefix\" substr(\$0, index(\$0, \"$separatorChar\") + 1) }"
    if test $lastLine; then
      break
    fi
  done

}

#
# Summary: Check that one or more binaries are installed
# Usage: {fn} usageFunction binary0 [ ... ]
# Argument: usageFunction - Required. `bash` function already defined to output usage
# Argument: binary0 - Required. Binary which must have a `which` path.
# Exit Codes: 1 - If any binary0 are not available within the current path
# Requires the binaries to be found via `which`
#
# Runs `usageFunction` on failure
#
usageRequireBinary() {
  local f b
  f="${1-}"
  if [ "$(type -t "$f")" != "function" ]; then
    consoleError "$f must be a valid function" 1>&2
    return $errorArgument
  fi
  shift || return $errorArgument
  for b in "$@"; do
    if [ -z "$(which "$b" || :)" ]; then
      "$f" "$errorEnvironment" "$b is not available in path, not found: $PATH"
    fi
  done
}

#
# Usage: {fn} usageFunction [ env0 ... ]
# Requires environment variables to be set and non-blank
# Argument: usageFunction - Required. `bash` function already defined to output usage
# Argument: env0 - Optional. String. One or more environment variables which should be set and non-empty.
# Exit Codes: 1 - If any env0 variables bre not set or bre empty.
# Deprecated: 2024-01-01
#
usageRequireEnvironment() {
  local f e
  f="${1-}"
  if [ "$(type -t "$f")" != "function" ]; then
    consoleError "$f must be a valid function" 1>&2
    return $errorArgument
  fi
  shift || return $errorArgument
  for e in "$@"; do
    if [ -z "${!e-}" ]; then
      "$f" 1 "Required $e not set"
      return 1
    fi
  done
}

# Validates a value is not blank and is a directory
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `directory`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
# Upon success, outputs the directory name trailing slash stripped
usageArgumentDirectory() {
  local usageFunction="${1-}" variableName="${2-}" variableValue="${3-}"
  local noun

  # shellcheck disable=SC2015
  shift && shift && shift || :
  noun="${*-directory}"
  if [ -z "$variableValue" ]; then
    "$usageFunction" "$errorArgument" "$variableName $noun is required"
    return $?
  fi
  if [ ! -d "$variableValue" ]; then
    "$usageFunction" "$errorArgument" "$variableName must be a $noun"
    return $?
  fi
  printf "%s\n" "${variableValue%%/}"
}

# Validates a value is not blank and is a file
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
# Upon success, outputs the file name
usageArgumentFile() {
  local usageFunction="${1-}" variableName="${2-}" variableValue="${3-}"
  local noun

  # shellcheck disable=SC2015
  shift && shift && shift || :
  noun="${*-file}"
  if [ -z "$variableValue" ]; then
    "$usageFunction" "$errorArgument" "$variableName $noun is required"
    return $?
  fi
  if [ ! -f "$variableValue" ]; then
    "$usageFunction" "$errorArgument" "$variableName must be a $noun"
    return $?
  fi
  printf "%s\n" "$variableValue"
}

# Validates a value is not blank and is a path with a directory that exists
# Usage: {fn} usageFunction variableName variableValue [ noun ]
# Argument: usageFunction - Required. Function. Run if usage fails
# Argument: variableName - Required. String. Name of variable being tested
# Argument: variableValue - Required. String. Required only in that if it's blank, it fails.
# Argument: noun - Optional. String. Noun used to describe the argument in errors, defaults to `file`
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success
# Upon success, outputs the file name
usageArgumentFileDirectory() {
  local usageFunction="${1-}" variableName="${2-}" variableValue="${3-}"
  local noun directory

  # shellcheck disable=SC2015
  shift && shift && shift || :
  noun="${*-file}"
  if [ -z "$variableValue" ]; then
    "$usageFunction" "$errorArgument" "$variableName $noun is required"
    return $?
  fi
  directory="$(dirname "$variableValue")"
  if [ ! -d "$directory" ]; then
    "$usageFunction" "$errorArgument" "$variableName $noun must be in a directory which exists: $directory"
    return $?
  fi
  printf "%s\n" "$variableValue"
}
