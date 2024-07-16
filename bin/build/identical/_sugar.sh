#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/_sugar.md
# Test: o ./test/tools/sugar-tests.sh
#
# -- CUT BELOW HERE --

# IDENTICAL _sugar EOF

# Usage: {fn} [ separator [ prefix [ suffix [ title [ item ... ] ] ] ]
# Formats a titled list as {title}{separator}{prefix}{item}{suffix}{prefix}{item}{suffix}...
# Argument: separator - Optional. String.
# Argument: prefix - Optional. String.
# Argument: suffix - Optional. String.
# Argument: title - Optional. String.
# Argument: item - Optional. String. One or more items to list.
_format() {
  local sep="${1-}" prefix="${2-}" suffix="${3-}" title="${4-"§"}"
  sep="${sep//%/%%}" && prefix="${prefix//%/%%}" && suffix="${suffix//%/%%}"
  shift && shift && shift && shift
  printf -- "%s$sep%s\n" "$title" "$(printf -- "$prefix%s$suffix" "$@")"
}

# Output a titled list
# Usage: {fn} title [ items ... ]
_list() {
  _format "\n" "- " "\n" "$@"
}

# Output a command
# Usage: {fn} command [ argument ... ]
_command() {
  _format "" " \"" "\"" "$@"
}

# Usage: {fn} name ...
# Argument: name - Optional. String. Exit code value to output
# Print one or more an exit codes by name. Master list of exit code values.
# Valid codes:
# - `environment` - generic issue with environment
# - `argument` - issue with arguments
# - `assert` - assertion failed
# - `identical` - identical check failed
# - `leak` - function leaked globals
# - `test` - test failed
# - `internal` - internal errors
# Unknown error code is 254, end of range is 255 which is not used
# See: https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux
_code() {
  local k && while [ $# -gt 0 ]; do
    case "$(printf "%s" "$1" | tr '[:upper:]' '[:lower:]')" in
      environment) k=1 ;; argument) k=2 ;; assert) k=97 ;; identical) k=105 ;; leak) k=108 ;; test) k=116 ;; internal) k=253 ;; *) k=254 ;;
    esac && shift && printf "%d\n" "$k"
  done
}

# Boolean test
# Returns 0 if `value` is an unsigned integer
# Usage: {fn} value
# Is this a boolean? (`true` or `false`)
# Exit Code: 0 - if value is a boolean
# Exit Code: 1 - if value is not a boolean
_boolean() {
  case "${1-}" in true | false) ;; *) return 1 ;; esac
}

# Boolean selector
# Usage: {fn} testValue trueChoice falseChoice
_choose() {
  local testValue
  testValue="${1-}" && shift
  _boolean "$testValue" || _argument "_choose non-boolean: \"$testValue\"" || return $?
  "$testValue" && printf "%s\n" "${1-}" || printf "%s\n" "${2-}"
}

# Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# Return `$errorArgument` always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

#
# RUN related
#

# Run `command ...` (with any arguments) and then `_return` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
__execute() {
  "$@" || _return $? "$(_command "$@")" || return $?
}

# Run `command ...` (with any arguments) and then `_exit` if it fails. Critical code only.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: None
__try() {
  __execute "$@" || _return $? "💣 $(_command "$@")" || exit $?
}

# Output the `command ...` to stdout prior to running, then `__execute` it
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: Any
__echo() {
  printf "➡️ %s\n" "$(_command "$@")" && __execute "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_environment` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
__environment() {
  "$@" || _environment "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_argument` if it fails.
# Usage: {fn} command ...FUNCNAME
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 2 - Failed
__argument() {
  "$@" || _argument "$@" || return $?
}
