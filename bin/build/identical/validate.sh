#!/bin/bash
#
# Identical template
#
# Original of validate
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL validate EOF

# Validate a value by type
# Argument: handler - Function. Required. Error handler.
# Argument: type - Type. Required. Type to validate.
# Argument: name - String. Required. Name of the variable which is being validated.
# Argument: value - EmptyString. Required. Value to validate.
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
validate() {
  local handler="_${FUNCNAME[0]}"
  local prefix="__validateType"

  [ $# -eq 0 ] || __help "$handler" "$@" || return 0
  [ $# -ge 4 ] || throwArgument "$handler" "Missing arguments - expect 4 or more (#$#: $(decorate each code "$@"))" || return $?

  local handler="$1" && shift

  while [ $# -ge 3 ]; do
    local type="$1" name="$2" value="$3"
    if isFunction _validateTypeMapper; then
      type=$(_validateTypeMapper "$type")
    fi
    local typeFunction="$prefix$type"
    isFunction "$typeFunction" || throwArgument "$handler" "validate $type is not a valid type:"$'\n'"$(validateTypeList)" || return $?
    if ! value=$("$typeFunction" "$value" 2>&1); then
      local suffix=""
      [ -z "$value" ] || suffix=" $(decorate error "$value")"
      throwArgument "$handler" "$name ($(decorate each code "$@")) is not type $(decorate label "$type")$suffix" || return $?
    fi
    printf -- "%s\n" "$value"
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
__validateTypeString() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  printf "%s\n" "${1-}"
}

__validateTypePositiveInteger() {
  isPositiveInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}

__validateTypeFunction() {
  isFunction "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}
