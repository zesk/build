#!/usr/bin/env bash
#
# Syntactic Sugar makes coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/_sugar.md
# Test: o ./test/tools/sugar-tests.sh
#
# -- CUT BELOW HERE --

# IDENTICAL _sugar EOF

# Argument: name ... - Optional. String. Exit code value to output.
# Print one or more return codes by name.
#
# Known codes:
#
# - `success` (0) - success!
# - `environment` (1) - generic issue with environment
# - `argument` (2) - issue with arguments
# - `assert` (97) - assertion failed (ASCII 97 = `a`)
# - `identical` (105) - identical check failed (ASCII 105 = `i`)
# - `leak` (108) - function leaked globals (ASCII 108 = `l`)
# - `timeout` (116) - timeout exceeded (ASCII 116 = `t`)
# - `exit` - (120) exit function immediately (ASCII 120 = `x`)
# - `not-found` - (127) command not found
# - `interrupt` - (141) Interrupt signal
# - `internal` - (253) internal errors
#
# Unknown error code is 254, end of range is 255 which is not used. Use `exitString` to get a string from an exit code integer.
#
# See: https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux
# File: bin/build/errno.txt
#
# Requires: usageDocument printf
# See: exitString
# Exit Code: 0
_code() {
  local k && while [ $# -gt 0 ]; do case "$1" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; success) k=0 ;; environment) k=1 ;; argument) k=2 ;; assert) k=97 ;; identical) k=105 ;; leak) k=108 ;; timeout) k=116 ;; exit) k=120 ;; interrupt) k=141 ;; internal) k=253 ;; *) k=254 ;; esac && shift && printf -- "%d\n" "$k"; done
}

# _IDENTICAL_ _exitString 8

# Output the exit code as a string
# Winner of the one-line bash award 10 years running
# Argument: code ... - UnsignedInteger. String. Exit code value to output.
# stdout: exitCodeToken, one per line
exitString() {
  local k="" && while [ $# -gt 0 ]; do case "$1" in 0) k="success" ;; 1) k="environment" ;; 2) k="argument" ;; 97) k="assert" ;; 105) k="identical" ;; 108) k="leak" ;; 116) k="timeout" ;; 120) k="exit" ;; 127) k="not-found" ;; 141) k="interrupt" ;; 253) k="internal" ;; 254) k="unknown" ;; *) k="[exitString unknown \"$1\"]" ;; esac && [ -n "$k" ] || k="$1" && printf "%s\n" "$k" && shift; done
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
# Requires: isBoolean _argument printf
# Argument: testValue - Boolean. Required. Test value
# Argument: trueChoice - EmptyString. Optional. Value to output when testValue is `true`
# Argument: falseChoice - EmptyString. Optional. Value to output when testValue is `false`
_choose() {
  local testValue="${1-}" && shift
  isBoolean "$testValue" || _argument "${BASH_SOURCE[1]-no function name}:${BASH_LINENO[0]-no line} ${FUNCNAME[1]} -> ${FUNCNAME[0]} non-boolean: \"$testValue\"" || return $?
  "$testValue" && printf -- "%s\n" "${1-}" || printf -- "%s\n" "${2-}"
}

# Delete files or directories and return the same exit code passed in.
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

# Return `argument` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code. Outputs `message ...` to `stderr`.
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
