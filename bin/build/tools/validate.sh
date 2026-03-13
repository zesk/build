#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# validate - Check your inputs
#
# Test: ./test/tools/validate-tests.sh
# Docs: ./documentation/source/tools/validate.md

# IDENTICAL validate 169

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
# - `Type` - (no aliases) - A type which can be validated by `validate`
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
#
# `validate` is intended to be extensible as well as reducible to smaller sizes by limiting type validation to used
# types only. The core validation types can be used **CASE-SENSITIVE ONLY** in smaller scripts using the core `validate`
# identical document which includes:
#
# - `String`
# - `PositiveInteger`
# - `Function`
# - `Callable`
# - `Type`
#
# The function `_validateTypeMapper` is defined and can map types to internal types. If not present, then no conversion
# is done. For a type to be considered valid, the corresponding `__validateType` prefixed function **MUST** exist.
#
# Internally the function `_validateTypeMapperDefault` is the default type mapper and does the stringLowercase and alias lookups.
#
# Return Code: 0 - Valid is valid, stdout is a filtered version of the value to be used
# Return Code: 2 - Valid is invalid, output reason to stderr
# Requires: __validateTypeString __validateTypePositiveInteger __validateTypeFunction __validateTypeCallable __validateTypeType
# Requires: isFunction throwArgument __help decorate
validate() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ $# -ge 4 ] || throwArgument "$handler" "Missing arguments - expect 4 or more (#$#: $(decorate each code -- "$@"))" || return $?

  local handler="$1" && shift

  local name="" index=0
  while [ $# -ge 3 ]; do
    index=$((index + 1))
    # name is carried between groups if blank
    name="${2:-"$name"}"
    [ -n "$name" ] || throwArgument "$handler" "[#$index] name required" || return $?
    local type="$1" value="$3" typeFunction=""
    __validateMapper "$type"
    isFunction "$typeFunction" || throwArgument "$handler" "[#$index $name] validate $type is not a valid type:"$'\n'"$(validateTypeList)" || return $?
    # Outputs stdout value if successful
    if ! "$typeFunction" "$value"; then
      local suffix="" ess="s" && [ "${#value}" -ne 1 ] || ess=""
      [ -z "$value" ] || suffix=" $(decorate error "$value")"
      throwArgument "$handler" "[#$index $name] \"$(decorate code "$value")\" [${#value} char$ess]) is not type $(decorate label "$type")$suffix" || return $?
    fi
    shift 3
  done
}
_validate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Handles extension via `_validateTypeMapper`
# Internal
# Locals Modified: type typeFunction
# Argument: type - String. Type to optionally map.
# Requires: isFunction
__validateMapper() {
  local prefix="__validateType"
  if isFunction _validateTypeMapper; then
    type=$(_validateTypeMapper "$1")
  fi
  typeFunction="$prefix$type"
}

# output arguments to stderr and return the argument error
# Return: 2
# Return Code: 2 - Argument error
_validateThrow() {
  printf -- "%s\n" "$@" 1>&2
  return 2
}

# Valid validate type
# Requires: _validateThrow
__validateTypeType() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  local type="${1-:__NOT__}" typeFunction=""
  __validateMapper "$type"
  isFunction "$typeFunction" || _validateThrow "Invalid type $1 -> $type" || return $?
  printf "%s\n" "$type"
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

################################################################################

#
#   _   _      _
#  | | | | ___| |_ __   ___ _ __ ___
#  | |_| |/ _ \ | '_ \ / _ \ '__/ __|
#  |  _  |  __/ | |_) |  __/ |  \__ \
#  |_| |_|\___|_| .__/ \___|_|  |___/
#               |_|
#

_validateHelperApplicationTest() {
  local test="$1" home="$2" item="$3"
  [ -n "$item" ] || _validateThrow "blank" || return $?
  item="${item#./}"
  item="${item#/}"
  test "$test" "$home/$item" || _validateThrow || return $?
  printf "%s\n" "$item"
}

# Utility function for `test`
_validateHelperCheck() {
  local testFlag="$1" && shift
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  test "$testFlag" "$@" || _validateThrow || return $?
  printf "%s\n" "$@"
}

#  __     __    _ _     _       _         _____                 _   _
#  \ \   / /_ _| (_) __| | __ _| |_ ___  |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
#   \ \ / / _` | | |/ _` |/ _` | __/ _ \ | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
#    \ V / (_| | | | (_| | (_| | ||  __/ |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
#     \_/ \__,_|_|_|\__,_|\__,_|\__\___| |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

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

__validateTypeInteger() {
  isInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}

__validateTypeNumber() {
  isNumber "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
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
  local home directories=() directory dd=() index=0

  home=$(catchReturn "$handler" buildHome) || return $?
  home="${home%/}"
  IFS=":" read -r -a directories <<<"$value" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    directory="$(___validateTypeApplicationDirectory "$home" "$directory")" || _validateThrow "element #$index ($(decorate error "$directory"): $(decorate value "$value")" || return $?
    dd+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${dd[@]+"${dd[@]}"}")"
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
  booleanParse "${1-}" || rs=$?
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
  local directories=() directory dd=() index=0
  IFS=":" read -d $'\n' -r -a directories <<<"$value" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    [ -n "$directory" ] || continue
    [ -d "$directory" ] || _validateThrow "element #$index is not type directory $(decorate code "$directory"): $(decorate value "$value")" || return $?
    dd+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${dd[@]+"${dd[@]}"}")"
}

# A valid environment variable name
__validateTypeEnvironmentVariable() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  environmentVariableNameValid "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}

# Validates a value is not blank and exists in the file system
__validateTypeExists() {
  _validateHelperCheck -e "$@" || return $?
}

# A file exists
__validateTypeFile() {
  _validateHelperCheck -f "$@" || return $?
}

# A directory exists
__validateTypeDirectory() {
  _validateHelperCheck -d "${1%/}" || return $?
}

# A link exists
__validateTypeLink() {
  _validateHelperCheck -L "$@" || return $?
}

# A file directory exists (file may exist or not)
__validateTypeFileDirectory() {
  local value="${1-}"
  [ -n "$value" ] || _validateThrow "blank" || return $?
  fileDirectoryExists "$value" || _validateThrow "Parent directory does not exist for $value" || return $?
  printf "%s\n" "${1-}"
}

# A real path for a directory
__validateTypeRealDirectory() {
  local value="${1-}"
  [ -n "$value" ] || _validateThrow "blank" || return $?
  value=$(fileRealPath "$value") || _validateThrow "fileRealPath failed" || return $?
  [ -d "$value" ] || _validateThrow || return $?
  printf "%s\n" "${value%/}"
}

# A real path for a file
__validateTypeRealFile() {
  local value="${1-}"
  [ -n "$value" ] || _validateThrow "blank" || return $?
  value=$(fileRealPath "$value") || _validateThrow "fileRealPath failed" || return $?
  printf "%s\n" "$value"
}

# A real path for a file's directory (file may not exist)
__validateTypeRealFileDirectory() {
  local value="${1-}"
  [ -n "$value" ] || _validateThrow "blank" || return $?
  local wantDir="" && [ "${value%/}" = "$value" ] || wantDir="/"
  fileDirectoryExists "$value" || _validateThrow "Parent directory does not exist for $value" || return $?
  value="$(fileRealPath "$(dirname "$value")")/$(basename "$value")$wantDir" || _validateThrow "fileRealPath failed" || return $?
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

# Validates a value as an environment file which is loaded immediately.
#
# Argument: variableValue - String. Required.
# Return Code: 2 - Argument error
# Return Code: 0 - Success
__validateTypeLoadEnvironmentFile() {
  local handler="returnMessage"
  local envFile bashEnv

  envFile=$(__validateTypeFile "$@") || return $?
  bashEnv=$(fileTemporaryName "$handler") || return $?
  catchEnvironment "$handler" environmentFileToBashCompatible "$envFile" >"$bashEnv" || returnClean $? "$bashEnv" || return $?
  local exitCode=0
  set -a
  # shellcheck source=/dev/null
  source "$bashEnv" || exitCode=$?
  set +a
  catchEnvironment "$handler" rm -f "$bashEnv" || return $?
  [ "$exitCode" != 0 ] || printf -- "%s\n" "$envFile"
  return "$exitCode"
}

# List types which can be validated
validateTypeList() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local prefix="__validateType"
  declare -F | textRemoveFields 2 | grepSafe -e "^$prefix" | cut -c "$((${#prefix} + 1))"- | sort
}
_validateTypeList() {
  true || validateTypeList --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Are all arguments passed a valid validate type?
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: type - String. Optional. Type to validate as `validate` type.
# Example:     isValidateType string || returnMessage 1 "string is not a type."
isValidateType() {
  local handler="_${FUNCNAME[0]}"

  local prefix="__validateType"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local mapped
      mapped=$(_validateTypeMapper "$argument")
      isFunction "$prefix$mapped" || throwArgument "$handler" "Invalid type $argument (-> \"$mapped\")" || return $?
      ;;
    esac
    shift
  done
}
_isValidateType() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_validateTypeMapper() {
  _validateTypeMapperDefault "$@"
}

# Default type mapping for `validate`
# 1. `stringLowercase`
# 2. Map aliases to internal types (CamelCase)
# stdout: Type
_validateTypeMapperDefault() {
  while [ $# -gt 0 ]; do
    local t="$1"
    case "$(stringLowercase "$t")" in
    string) t=String ;;
    emptystring | string? | any) t=EmptyString ;;
    array) t=Array ;;
    list) t=List ;;
    flag) t=Flag ;;
    colondelimitedlist | list:) t=ColonDelimitedList ;;
    commadelimitedlist | list,) t=CommaDelimitedList ;;
    unsignedinteger | uint | unsigned) t=UnsignedInteger ;;
    positiveinteger | positive) t=PositiveInteger ;;
    integer | int) t=Integer ;;
    number) t=Number ;;
    function) t=Function ;;
    callable) t=Callable ;;
    executable | bin) t=Executable ;;
    applicationdirectory | appdir) t=ApplicationDirectory ;;
    applicationfile | appfile) t=ApplicationFile ;;
    applicationdirectorylist | appdirlist) t=ApplicationDirectoryList ;;
    boolean | bool) t=Boolean ;;
    booleanlike | "boolean?" | "bool?") t=BooleanLike ;;
    date) t=Date ;;
    directorylist | dirlist) t=DirectoryList ;;
    environmentvariable | env) t=EnvironmentVariable ;;
    loadenvironmentfile | load-env) t=LoadEnvironmentFile ;;
    exists) t=Exists ;;
    file) t=File ;;
    directory | dir) t=Directory ;;
    link) t=Link ;;
    filedirectory | parent) t=FileDirectory ;;
    realdirectory | realdir) t=RealDirectory ;;
    realfile | real) t=RealFile ;;
    realfiledirectory | realparent) t=RealFileDirectory ;;
    remotedirectory | remotedir) t=RemoteDirectory ;;
    secret) t=Secret ;;
    url) t=URL ;;
    *) ;;
    esac
    printf "%s\n" "$t"
    shift
  done
}
