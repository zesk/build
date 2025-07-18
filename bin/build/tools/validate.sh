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
#
# Types are equivalent on each line:
#
#    String                    string
#    EmptyString               string?
#    Array                     array
#    List                      list
#    ColonDelimitedList        list:
#    CommaDelimitedList        list,
#    UnsignedInteger           uint unsigned
#    PositiveInteger           positive
#    Integer                   int integer
#    Number                    number
#    Function                  function
#    Callable                  callable
#    Executable                bin executable
#    ApplicationDirectory      appdir
#    ApplicationFile           appfile
#    ApplicationDirectoryList  appdirlist
#    Boolean                   boolean bool
#    BooleanLike               boolean? bool?
#    Date                      date
#    DirectoryList             dirlist
#    EnvironmentVariable       env
#    Exists                    exists
#    File                      file
#    Directory                 directory dir
#    Link                      link
#    FileDirectory             parent
#    RealDirectory             realdir
#    RealFile                  real
#    RemoteDirectory           remotedirectory | remotedir
#    Secret                    secret
#    URL                       url
#
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
    type=$(_validateTypeMapper "$type")
    local typeFunction="$prefix$type"
    isFunction "$typeFunction" || __throwArgument "$usage" "validate $type is not a valid type:"$'\n'"$(validateTypeList)" || return $?
    if ! value=$("$typeFunction" "$value" 2>&1); then
      local suffix=""
      [ -z "$value" ] || suffix=" $(decorate error "$value")"
      __throwArgument "$handler" "$name ($(decorate each code "$@")) is not type $(decorate label "$type")$suffix" || return $?
    fi
    printf -- "%s\n" "$value"
    shift 3
  done
}
_validate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List types which can be validated
validateTypeList() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local prefix="__validateType"
  declare -F | removeFields 2 | grepSafe -e "^$prefix" | cut -c "$((${#prefix} + 1))"- | sort
}
_validateTypeList() {
  true || validateTypeList --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
    shift
  done
}
_isValidateType() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Do not use anything with special meanings in bash (like `*`) for type aliases.
_validateTypeAliases() {
  cat <<'EOF'
String string
EmptyString string?
Array
List 
ColonDelimitedList list:
CommaDelimitedList list,
UnsignedInteger uint | unsigned
PositiveInteger positive
Integer int 
Number
Function
Callable
Executable bin
ApplicationDirectory appdir
ApplicationFile appfile
ApplicationDirectoryList appdirlist
Boolean bool
BooleanLike boolean? bool?
Date
DirectoryList dirlist
EnvironmentVariable env
Exists
File
Directory dir
Link
FileDirectory parent
RealDirectory realdir
RealFile  real
RemoteDirectory remotedir
Secret
URL
EOF
}

#
#   _   _      _
#  | | | | ___| |_ __   ___ _ __ ___
#  | |_| |/ _ \ | '_ \ / _ \ '__/ __|
#  |  _  |  __/ | |_) |  __/ |  \__ \
#  |_| |_|\___|_| .__/ \___|_|  |___/
#               |_|
#

# Convert from short type to long type
_validateTypeMapper() {
  read -r type aliases < <(_validateTypeAliases | grepSafe -i -e "\b$(quoteGrepPattern "$1")\b")
  [ -n "$type" ] || type="$1"
  printf "%s\n" "$type"
  : "$aliases"
}

_validateHelperApplicationTest() {
  local test="$1" home="$2" item="$3"
  [ -n "$item" ] || _validateThrow "blank" || return $?
  item="${item#./}"
  item="${item#/}"
  test "$test" "$home/$item" || _validateThrow || return $?
  printf "%s\n" "$item"
}

# Utility function for `test`
_validateHelperTest() {
  _validateHelperCheck "$@" && shift || return $?
  printf "%s\n" "$@"
}

# Utility function for `test`
_validateHelperCheck() {
  local testFlag="$1" && shift
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  test "$testFlag" "$@" || _validateThrow || return $?
  printf "%s\n" "$@"
}

# output arguments to stderr and return the argument error
# Return: 2
# Exit Code: 2 - Argument error
_validateThrow() {
  printf -- "%s\n" "$@" 1>&2
  return 2
}

#  __     __    _ _     _       _         _____                 _   _
#  \ \   / /_ _| (_) __| | __ _| |_ ___  |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
#   \ \ / / _` | | |/ _` |/ _` | __/ _ \ | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
#    \ V / (_| | | | (_| | (_| | ||  __/ |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
#     \_/ \__,_|_|_|\__,_|\__,_|\__\___| |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

# Non-empty string
__validateTypeString() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  printf "%s\n" "${1-}"
}

# Any value passes
__validateTypeEmptyString() {
  printf "%s\n" "${1-}"
  return 0
}

# Boolean parsing
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

# Zero or more additional arguments
__validateTypeArguments() {
  __validateTypeEmptyString "$@"
}

# `,`-delimited list
__validateTypeCommaDelimitedList() {
  __validateTypeEmptyString "$@"
}

# unsigned integer is greater than or equal to zero
__validateTypeUnsignedInteger() {
  isUnsignedInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}

__validateTypePositiveInteger() {
  isPositiveInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}

__validateTypeInteger() {
  isInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}

__validateTypeNumber() {
  isNumber "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}

__validateTypeFunction() {
  isFunction "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}

__validateTypeCallable() {
  isCallable "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}

__validateTypeExecutable() {
  isExecutable "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}

__validateTypeApplicationDirectory() {
  local home directory="${1-}"
  home=$(buildHome) || return $?
  _validateHelperApplicationTest -d "$home" "${directory%/}" || return $?
}

__validateTypeApplicationFile() {
  local home file="${1-}"
  home=$(buildHome) || return $?
  _validateHelperApplicationTest -f "$home" "$file" || return $?
}

__validateTypeApplicationDirectoryList() {
  local value="${1-}"
  local home directories=() directory result=() index=0

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  home="${home%/}"
  IFS=":" read -r -a directories <<<"$value" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    directory="$(___validateTypeApplicationDirectory "$home" "$directory")" || _validateThrow "element #$index ($(decorate error "$directory"): $(decorate value "$value")" || return $?
    result+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${result[@]+"${result[@]}"}")"
}

# Flags are command line options which set a value to true, usually
# Placeholder to add type to list
__validateTypeFlag() {
  return 0
}

# Strict boolean `false` or `true`
__validateTypeBoolean() {
  isBoolean "${1-}" || _validateThrow || return $?
  printf "%s\n" "$1"
}

# Boolean-like value
__validateTypeBooleanLike() {
  local rs=0
  parseBoolean "${1-}" || rs=$?
  case "$rs" in
  0) rs="true" ;;
  1) rs="false" ;;
  *) _validateThrow "parse boolean failed" || return $? ;;
  esac
  printf "%s\n" "$rs"
}

# Date formatted like YYYY-MM-DD
__validateTypeDate() {
  dateValid "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}

# List of directories separated by `:`
__validateTypeDirectoryList() {
  local value="${1-}"
  local directories=() directory result=() index=0
  IFS=":" read -r -a directories <<<"$value" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    [ -n "$directory" ] || continue
    [ -d "$directory" ] || _validateThrow "element #$index not directory $(decorate code "$directory"): $(decorate value "$value")" || return $?
    result+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${result[@]+"${result[@]}"}")"
}

# A valid environment variable name
__validateTypeEnvironmentVariable() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  environmentVariableNameValid "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}

# Validates a value is not blank and exists in the file system
__validateTypeExists() {
  _validateHelperTest -e "$@" || return $?
}

# A file exists
__validateTypeFile() {
  _validateHelperTest -f "$@" || return $?
}

# A directory exists
__validateTypeDirectory() {
  _validateHelperCheck -d "$@" || return $?
  printf "%s\n" "${1%/}"
}

# A link exists
__validateTypeLink() {
  _validateHelperTest -L "$@" || return $?
}

# A file directory exists (file may exist or not)
__validateTypeFileDirectory() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  fileDirectoryExists "${1-}" || _validateThrow "Parent directory does not exist for $1" || return $?
  printf "%s\n" "${1-}"
}

# A real path for a directory
__validateTypeRealDirectory() {
  local value="${1-}"
  [ -n "$value" ] || _validateThrow "blank" || return $?
  value=$(realPath "$value") || _validateThrow "realPath failed" || return $?
  [ -d "$value" ] || _validateThrow || return $?
  printf "%s\n" "${value%/}"
}

# A real path for a file
__validateTypeRealFile() {
  local value="${1-}"
  [ -n "$value" ] || _validateThrow "blank" || return $?
  value=$(realPath "$value") || _validateThrow "realPath failed" || return $?
  printf "%s\n" "$value"
}

# A path which is on a remote system
__validateTypeRemoteDirectory() {
  [ "${1:0:1}" = "/" ] || _validateThrow "begins with a slash" || return $?
  printf "%s\n" "${1%/}"
}

# A secret
__validateTypeSecret() {
  __validateTypeString "$@"
}

# An URL
__validateTypeURL() {
  urlValid "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}
