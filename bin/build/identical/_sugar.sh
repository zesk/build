#!/usr/bin/env bash
#
# EDIT THIS FILE
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
  exec 2>/dev/null && shift && shift && shift && shift
  printf -- "%s$sep%s\n" "$title" "$(printf -- "$prefix%s$suffix" "$@")"
}

# Output a titled list
# Usage: {fn} title [ items ... ]
_list() {
  _format "\n" "- " "\n" "$@"
}

# Output a command, quoting individual arguments
# Usage: {fn} command [ argument ... ]
_command() {
  _format "" " \"" "\"" "$@"
}

# Usage: {fn} name ...
# Argument: name ... - Optional. String. Exit code value to output.
# Print one or more an exit codes by name.
#
# Valid codes:
#
# - `environment` - generic issue with environment
# - `argument` - issue with arguments
# - `assert` - assertion failed
# - `identical` - identical check failed
# - `leak` - function leaked globals
# - `test` - test failed
# - `exit` - exit function immediately
# - `internal` - internal errors
#
# Unknown error code is 254, end of range is 255 which is not used.
#
# ### Error codes reference (`_code`):
#
# - 1 - environment or general error
# - 2 - argument error
# - 97 - assert - ASCII 97 = `a`
# - 105 - identical - ASCII 105 = `i`
# - 108 - leak - ASCII 108 = `l`
# - 116 - test - ASCII 116 = `t`
# - 120 - exit - ASCII 120 = `x`
# - 253 - internal
# - 254 - unknown
#
# See: https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux
_code() {
  local k && while [ $# -gt 0 ]; do
    case "$(printf "%s" "$1" | tr '[:upper:]' '[:lower:]')" in
      environment) k=1 ;; argument) k=2 ;; assert) k=97 ;; identical) k=105 ;; leak) k=108 ;; test) k=116 ;; exit) k=120 ;; internal) k=253 ;; *) k=254 ;;
    esac && shift && printf "%d\n" "$k"
  done
}

# Boolean test
# Returns 0 if `value` is boolean `false` or `true`.
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
  local testValue="${1-}" && shift
  _boolean "$testValue" || _argument "${FUNCNAME[1]-no function name}:${BASH_LINENO[1]-no line} -> ${FUNCNAME[0]} _choose non-boolean: \"$testValue\"" || return $?
  "$testValue" && printf "%s\n" "${1-}" || printf "%s\n" "${2-}"
}

# Usage: {fn} exitCode item ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
_clean() {
  local exitCode="${1-}"
  shift
  _integer "$exitCode" || _argument "${FUNCNAME[0]} $exitCode (not an integer) $*" || return $?
  while [ $# -gt 0 ]; do
    [ ! -f "$1" ] || __environment rm "$1" || return $?
    [ ! -d "$1" ] || __environment rm -rf "$1" || return $?
    shift
  done
  return "$exitCode"
}

# Return `environment` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# Return `argument` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_return` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
__execute() {
  "$@" || _return $? "$(_command "$@")" || return $?
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
