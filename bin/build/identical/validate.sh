#!/bin/bash
#
# Identical template
#
# Original of validate
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL validate EOF

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
# Return Code: 0 - `value` is valid, stdout is a filtered version of the value to be used
# Return Code: 2 - `value` is invalid, output reason to stderr
# Return Code: 120 - `value` is invalid, return calling function immediately
# Requires: __validateTypeString __validateTypePositiveInteger __validateTypeFunction __validateTypeCallable __validateTypeType
# Requires: isFunction throwArgument helpArgument decorate
validate() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
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
    local returnCode=0 && "$typeFunction" "$value" || returnCode=$?
    case "$returnCode" in 0) shift 3 ;; 120) return "$returnCode" ;; *)
      local suffix="" ess="s" && [ "${#value}" -ne 1 ] || ess=""
      [ -z "$value" ] || suffix=" $(decorate error "$value")"
      throwArgument "$handler" "[#$index $name] \"$(decorate code "$value")\" [${#value} char$ess]) is not type $(decorate label "$type")$suffix" || return $?
      ;;
    esac
  done
}
_validate() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
