#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# validate
#
# Test: ./test/tools/validate-tests.sh
# Docs: ./documentation/source/tools/validate.md

# Validate a value by type
# Argument: handler - Function. Required. Error handler.
# Argument: type - Type. Required. Type to validate.
# Argument: name - String. Required. Name of the variable which is being validated.
# Argument: value - EmptyString. Required. Value to validate.
# You can repeat the `type` `name` `value` more than once in the arguments and each will be checked until one fails
# Exit Code: 0 - Valid is valid, stdout is a filtered version of the value to be used
# Exit Code: 2 - Valid is invalid, output reason to stderr
validate() {
  local usage="_${FUNCNAME[0]}"
  local prefix="__validateType"

  [ $# -eq 0 ] || __help "$usage" "$@" || return 0
  [ $# -ge 4 ] || __throwArgument "$usage" "Missing arguments - expect 4 or more (#$#: $(decorate each code "$@"))" || return $?

  local handler="$1" && shift

  while [ $# -ge 3 ]; do
    local type="$1" name="$2" value="$3"
    local typeFunction="$prefix$type"
    isFunction "$typeFunction" || __throwArgument "$usage" "validate $type is not a valid type:"$'\n'"$(validateTypeList)" || return $?
    if ! value=$("$typeFunction" "$value" 2>&1); then
      local suffix=""
      [ -z "$value" ] || suffix=" $(decorate error "$value")"
      __throwArgument "$handler" "$name ($(decorate each code "$@")) is not type $(decorate label "$type")$suffix" || return $?
    fi
    __catchEnvironment "$usage" printf -- "%s\n" "$value" || return $?
    shift 3
  done
}

# List types which can be validated
validateTypeList() {
  local prefix="__validateType"
  declare -F | removeFields 2 | grepSafe -e "^$prefix" | cut -c "$((${#prefix} + 1))"- | sort
}

# Are all arguments passed a valid validate type?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
isValidateType() {
  local usage="_${FUNCNAME[0]}"

  local prefix="__validateType"

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
      *)
        isFunction "$prefix$argument" || __throwArgument "$usage" "Invalid type $argument" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}

# Non-empty string
__validateTypeString() {
  [ -n "${1-}" ] || __throwValidate "blank" || return $?
  printf "%s\n" "${1-}"
}

# Any value passes
__validateTypeEmptyString() {
  printf "%s\n" "${1-}"
  return 0
}

# Arrays can be zero-length so any value passes
__validateTypeArray() {
  __validateTypeEmptyString "$@"
}

# Lists can be zero-length so any value passes
__validateTypeList() {
  __validateTypeEmptyString "$@"
}

# `:`-delimited list
__validateTypeColonDelimitedList() {
  __validateTypeEmptyString "$@"

}

# `,`-delimited list
__validateTypeCommaDelimitedList() {
  __validateTypeEmptyString "$@"
}

# unsigned integer is greater than or equal to zero
__validateTypeUnsignedInteger() {
  isUnsignedInteger "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1#+}"
}

__validateTypePositiveInteger() {
  isPositiveInteger "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1#+}"
}

__validateTypeInteger() {
  isInteger "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1#+}"
}

__validateTypeNumber() {
  isNumber "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1#+}"
}

__validateTypeFunction() {
  isFunction "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1-}"
}

__validateTypeCallable() {
  isCallable "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1-}"
}

__validateTypeExecutable() {
  isExecutable "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1-}"
}

___validateTypeApplicationTest() {
  local test="$1" home="$2" item="$3"
  [ -n "$item" ] || __throwValidate "blank" || return $?
  item="${item#./}"
  item="${item#/}"
  test "$test" "$home/$item" || __throwValidate || return $?
  printf "%s\n" "$item"
}

__validateTypeApplicationDirectory() {
  local home directory="${1-}"
  home=$(buildHome) || return $?
  ___validateTypeApplicationTest -d "$home" "${directory%/}" || return $?
}

__validateTypeApplicationFile() {
  local home file="${1-}"
  home=$(buildHome) || return $?
  ___validateTypeApplicationTest -f "$home" "$file" || return $?
}

__validateTypeApplicationDirectoryList() {
  local value="${1-}"
  local home directories=() directory result=() index=0

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  home="${home%/}"
  IFS=":" read -r -a directories <<<"$value" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    directory="$(___validateTypeApplicationDirectory "$home" "$directory")" || __throwValidate "element #$index ($(decorate error "$directory"): $(decorate value "$value")" || return $?
    result+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${result[@]+"${result[@]}"}")"
}

# Strict boolean `false` or `true`
__validateTypeBoolean() {
  isBoolean "${1-}" || __throwValidate || return $?
  printf "%s\n" "$1"
}

# Boolean-like value
__validateTypeBooleanLike() {
  local rs=0
  parseBoolean "${1-}" || rs=$?
  case "$rs" in
    0) rs="true" ;;
    1) rs="false" ;;
    *) __throwValidate "parse boolean failed" || return $? ;;
  esac
  printf "%s\n" "$rs"
}

# Date formatted like YYYY-MM-DD
__validateTypeDate() {
  dateValid "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1-}"
}

# List of directories separated by `:`
__validateTypeDirectoryList() {
  local value="${1-}"
  local directories=() directory result=() index=0
  IFS=":" read -r -a directories <<<"$value" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    [ -n "$directory" ] || continue
    [ -d "$directory" ] || __throwValidate "element #$index not directory $(decorate code "$directory"): $(decorate value "$value")" || return $?
    result+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${result[@]+"${result[@]}"}")"
}

# A valid environment variable name
__validateTypeEnvironmentVariable() {
  [ -n "${1-}" ] || __throwValidate "blank" || return $?
  environmentVariableNameValid "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1-}"
}

# Utility function for `test`
___validateTypeTest() {
  ___validateTypeCheck "$@" && shift || return $?
  printf "%s\n" "$@"
}

# Utility function for `test`
___validateTypeCheck() {
  local testFlag="$1" && shift
  [ -n "${1-}" ] || __throwValidate "blank" || return $?
  test "$testFlag" "$@" || __throwValidate || return $?
  printf "%s\n" "$@"
}

# Validates a value is not blank and exists in the file system
__validateTypeExists() {
  ___validateTypeTest -e "$@"
}

# A file exists
__validateTypeFile() {
  ___validateTypeTest -f "$@"
}

# A directory exists
__validateTypeDirectory() {
  ___validateTypeCheck -d "$@"
  printf "%s\n" "${1%/}"
}

# A link exists
__validateTypeLink() {
  ___validateTypeTest -L "$@"
}

# A file directory exists (file may exist or not)
__validateTypeFileDirectory() {
  [ -n "${1-}" ] || __throwValidate "blank" || return $?
  fileDirectoryExists "${1-}"
  printf "%s\n" "${1-}"
}

# A real path for a directory
__validateTypeRealDirectory() {
  local value="${1-}"
  [ -n "$value" ] || __throwValidate "blank" || return $?
  value=$(realPath "$value") || __throwValidate "realPath failed" || return $?
  [ -d "$value" ] || __throwValidate || return $?
  printf "%s\n" "${value%/}"
}

# A real path for a file
__validateTypeRealFile() {
  local value="${1-}"
  [ -n "$value" ] || __throwValidate "blank" || return $?
  value=$(realPath "$value") || __throwValidate "realPath failed" || return $?
  printf "%s\n" "$value"
}

# A path which is on a remote system
__validateTypeRemoteDirectory() {
  [ "${1:0:1}" = "/" ] || __throwValidate "begins with a slash" || return $?
  printf "%s\n" "${1%/}"
}

# A secret
__validateTypeSecret() {
  __validateTypeString "$@"
}

# An URL
__validateTypeURL() {
  urlValid "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1-}"
}

# output arguments to stderr and return the argument error
# Return: 2
# Exit Code: 2 - Argument error
__throwValidate() {
  printf -- "%s\n" "$@" 1>&2
  return 2
}
