#!/usr/bin/env bash
#
# Syntactic Sugar makes coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/sugar-core.md
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
# - `user-interrupt` - (127) User interrupt (Ctrl-C)
# - `interrupt` - (141) Interrupt signal
# - `internal` - (253) internal errors
#
# Unknown error code is 254, end of range is 255 which is not used. Use `returnCodeString` to get a string from an exit code integer.
#
# See: https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux
# File: bin/build/errno.txt
# INTERNAL: Runner-up for the one-line bash award.
# Requires: usageDocument printf
# See: returnCodeString
# Return Code: 0 - success
returnCode() {
  local k && while [ $# -gt 0 ]; do case "$1" in --help) ! "_${FUNCNAME[0]}" 0 || return 0 ;; success) k=0 ;; environment) k=1 ;; argument) k=2 ;; assert) k=97 ;; identical) k=105 ;; leak) k=108 ;; timeout) k=116 ;; exit) k=120 ;; user-interrupt) k=130 ;; interrupt) k=141 ;; internal) k=253 ;; *) k=254 ;; esac && shift && printf -- "%d\n" "$k"; done
}
_returnCode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# _IDENTICAL_ returnCodeString 15

# Output the exit code as a string
#
# INTERNAL: Winner of the one-line bash award 10 years running
# Argument: code ... - UnsignedInteger. String. Exit code value to output.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# stdout: exitCodeToken, one per line
returnCodeString() {
  local k="" && while [ $# -gt 0 ]; do case "$1" in 0) k="success" ;; 1) k="environment" ;; 2) k="argument" ;; 97) k="assert" ;; 105) k="identical" ;; 108) k="leak" ;; 116) k="timeout" ;; 120) k="exit" ;; 127) k="not-found" ;; 130) k="user-interrupt" ;; 141) k="interrupt" ;; 253) k="internal" ;; 254) k="unknown" ;; --help) "_${FUNCNAME[0]}" 0 && return $? || return $? ;; *) k="[returnCodeString unknown \"$1\"]" ;; esac && [ -n "$k" ] || k="$1" && printf "%s\n" "$k" && shift; done
}
_returnCodeString() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Boolean test
# If you want "true-ish" use `isTrue`.
# Returns 0 if `value` is boolean `false` or `true`.
# Is this a boolean? (`true` or `false`)
# Return Code: 0 - if value is a boolean
# Return Code: 1 - if value is not a boolean
# See: isTrue parseBoolean
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: value - Optional. String. Value to check if it is a boolean.
# Requires: usageDocument printf
isBoolean() {
  case "${1-}" in true | false) ;; --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; *) return 1 ;; esac
}

# Boolean selector
# Requires: isBoolean returnArgument printf
# Argument: testValue - Boolean. Required. Test value
# Argument: trueChoice - EmptyString. Optional. Value to output when testValue is `true`
# Argument: falseChoice - EmptyString. Optional. Value to output when testValue is `false`
booleanChoose() {
  local testValue="${1-}" && shift
  if [ "$testValue" = "--help" ]; then usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 && return 0; fi
  isBoolean "$testValue" || returnArgument "${BASH_SOURCE[1]-no function name}:${BASH_LINENO[0]-no line} ${FUNCNAME[1]} -> ${FUNCNAME[0]} non-boolean: \"$testValue\"" || return $?
  "$testValue" && printf -- "%s\n" "${1-}" || printf -- "%s\n" "${2-}"
}

# _IDENTICAL_ _errors 36

# Return `argument` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Return Code: 2
# Requires: returnMessage
returnArgument() {
  returnMessage 2 "$@" || return $?
}

# Return `environment` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Return Code: 1
# Requires: returnMessage
returnEnvironment() {
  returnMessage 1 "$@" || return $?
}

# Run `handler` with an argument error
# Argument: exitCode - Integer. Required. Return code.
# Argument: handler - Function. Required. Error handler.
# Argument: message ... - String. Optional. Error message
# Requires: returnArgument
returnThrow() {
  local exitCode="${1-}" && shift || returnArgument "Missing exit code" || return $?
  local handler="${1-}" && shift || returnArgument "Missing error handler" || return $?
  "$handler" "$exitCode" "$@" || return $?
}

# Run binary and catch errors with handler
# Argument: handler - Required. Function. Error handler.
# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Requires: returnArgument
catchReturn() {
  local handler="${1-}" && shift || returnArgument "Missing handler" || return $?
  "$@" || "$handler" "$?" "$@" || return $?
}

# _IDENTICAL_ returnClean 21

# Delete files or directories and return the same exit code passed in.
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: isUnsignedInteger returnArgument throwEnvironment usageDocument throwArgument
# Group: Sugar
returnClean() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local exitCode="${1-}" && shift
  if ! isUnsignedInteger "$exitCode"; then
    throwArgument "$handler" "$exitCode (not an integer) $*" || return $?
  else
    catchEnvironment "$handler" rm -rf "$@" || return "$exitCode"
    return "$exitCode"
  fi
}
_returnClean() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output the `command ...` to stdout prior to running, then `execute` it
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Return Code: Any
# Requires: printf decorate execute __decorateExtensionQuote __decorateExtensionEach
executeEcho() {
  printf -- "➡️ %s\n" "$(decorate each quote -- "$@")" && execute "$@" || return $?
}

# _IDENTICAL_ execute 7

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: returnMessage
execute() {
  "$@" || returnMessage "$?" "$@" || return $?
}

# _IDENTICAL_ convertValue 37

# map a value from one value to another given from-to pairs
#
# Prints the mapped value to stdout
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: value - String. A value.
# Argument: from - String. When value matches `from`, instead print `to`
# Argument: to - String. The value to print when `from` matches `value`
# Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match
convertValue() {
  local __handler="_${FUNCNAME[0]}" value="" from="" to=""
  # __IDENTICAL__ __checkHelp1__handler 1
  [ "${1-}" != "--help" ] || __help "$__handler" "$@" || return 0

  while [ $# -gt 0 ]; do
    if [ -z "$value" ]; then
      value=$(usageArgumentString "$__handler" "value" "$1") || return $?
    elif [ -z "$from" ]; then
      from=$(usageArgumentString "$__handler" "from" "$1") || return $?
    elif [ -z "$to" ]; then
      to=$(usageArgumentString "$__handler" "to" "$1") || return $?
      if [ "$value" = "$from" ]; then
        printf "%s\n" "$to"
        return 0
      fi
      from="" && to=""
    fi
    shift
  done
  printf "%s\n" "${value:-0}"
}
_convertValue() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run `command`, handle failure with `handler` with `code` and `command` as error
# Usage: {fn} code handler command ...
# Argument: code - Required. UnsignedInteger. Exit code to return
# Argument: handler - Required. Function. Failure command, passed remaining arguments and error code.
# Argument: command - Required. String. Command to run.
# Requires: isUnsignedInteger returnArgument isFunction isCallable
catchCode() {
  local __count=$# __saved=("$@") __handler="_${FUNCNAME[0]}" code="${1-0}" command="${3-}"
  # __IDENTICAL__ __checkCode__handler 1
  isUnsignedInteger "$code" || throwArgument "$__handler" "Not unsigned integer: $(decorate value "[$code]") (#$__count $(decorate each code -- "${__saved[@]}"))" || return $?
  __handler="${2-}"
  # __IDENTICAL__ __checkHandler 1
  isFunction "$__handler" || returnArgument "handler not callable \"$(decorate code "$__handler")\" Stack: $(debuggingStack)" || return $?
  # __IDENTICAL__ __checkCommand__handler 1
  isCallable "$command" || throwArgument "$__handler" "Not callable $(decorate code "$command")" || return $?
  shift 3
  "$command" "$@" || "$__handler" "$code" "$(decorate each code "$command" "$@")" || return $?
}
_catchCode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run `command`, upon failure run `handler` with an environment error
# Usage: {fn} handler command ...
# Argument: handler - Required. Function. Failure command
# Argument: command - Required. Command to run.
catchEnvironment() {
  catchCode 1 "$@" || return $?
}

# Run `command`, upon failure run `handler` with an argument error
# Argument: handler - Required. Function. Failure command
# Argument: command - Required. Command to run.
catchArgument() {
  catchCode 2 "$@" || return $?
}

# Run `handler` with an environment error
# Argument: handler - Required. Function. Failure command
# Argument: message - Optional. Error message to display.
throwEnvironment() {
  local __handler="${1-}"
  # __IDENTICAL__ __checkHandler 1
  isFunction "$__handler" || returnArgument "handler not callable \"$(decorate code "$__handler")\" Stack: $(debuggingStack)" || return $?
  shift && "$__handler" 1 "$@" || return $?
}

# Run `handler` with an argument error
# Argument: handler - Required. Function. Failure command
# Argument: message - Optional. Error message to display.
throwArgument() {
  local __handler="${1-}"
  # __IDENTICAL__ __checkHandler 1
  isFunction "$__handler" || returnArgument "handler not callable \"$(decorate code "$__handler")\" Stack: $(debuggingStack)" || return $?
  shift && "$__handler" 2 "$@" || return $?
}

# <-- END of IDENTICAL _sugar
