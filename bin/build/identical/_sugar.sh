#!/usr/bin/env bash
#
# Syntactic Sugar makes coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/_sugar.md
# Test: o ./test/tools/sugar-tests.sh
#
# -- CUT BELOW HERE --

# IDENTICAL _sugar EOF

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
# Requires: usageDocument printf
_code() {
  local k && while [ $# -gt 0 ]; do
    case "$1" in
      --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;;
      environment) k=1 ;; argument) k=2 ;; assert) k=97 ;; identical) k=105 ;; leak) k=108 ;; test) k=116 ;; exit) k=120 ;; internal) k=253 ;; *) k=254 ;;
    esac && shift && printf -- "%d\n" "$k"
  done
}

# Boolean test
# Returns 0 if `value` is boolean `false` or `true`.
# Usage: {fn} value
# Is this a boolean? (`true` or `false`)
# Exit Code: 0 - if value is a boolean
# Exit Code: 1 - if value is not a boolean
# Requires: usageDocument printf
isBoolean() {
  case "${1-}" in true | false) ;; *) return 1 ;; esac
}

# Boolean selector
# Usage: {fn} testValue trueChoice falseChoice
# Requires: isBoolean _argument printf
_choose() {
  local testValue="${1-}" && shift
  isBoolean "$testValue" || _argument "${BASH_SOURCE[1]-no function name}:${BASH_LINENO[0]-no line} ${FUNCNAME[1]} -> ${FUNCNAME[0]} non-boolean: \"$testValue\"" || return $?
  "$testValue" && printf -- "%s\n" "${1-}" || printf -- "%s\n" "${2-}"
}

# Usage: {fn} exitCode item ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: isUnsignedInteger _argument __environment
_clean() {
  local exitCode="${1-}" && shift
  isUnsignedInteger "$exitCode" || _argument "${FUNCNAME[0]} $exitCode (not an integer) $*" || return $?
  while [ $# -gt 0 ]; do
    [ ! -f "$1" ] || __environment rm "$1" || return $?
    [ ! -d "$1" ] || __environment rm -rf "$1" || return $?
    shift
  done
  return "$exitCode"
}

# _IDENTICAL_ _errors 16

# Return `argument` error code always. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code always. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
# Requires: _return
_environment() {
  _return 1 "$@" || return $?
}

# _IDENTICAL_ __execute 7

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}

# Output the `command ...` to stdout prior to running, then `__execute` it
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: Any
# Requires: printf decorate __execute __decorateExtensionQuote __decorateExtensionEach
__echo() {
  printf -- "➡️ %s\n" "$(decorate each quote "$@")" && __execute "$@" || return $?
}

# _IDENTICAL_  __environment 10

# Run `command ...` (with any arguments) and then `_environment` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
# Requires: _environment
__environment() {
  "$@" || _environment "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_argument` if it fails.
# Usage: {fn} command ...FUNCNAME
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 2 - Failed
# Requires: _argument
__argument() {
  "$@" || _argument "$@" || return $?
}
