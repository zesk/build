#!/usr/bin/env bash
#
# When you only need a little bit of syntactic sugar
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Minimum _sugar for install
# Requires IDENTICAL: returnMessage
#

# IDENTICAL _tinySugar EOF

# Run `handler` with an argument error
# Argument: handler - Function. Required. Error handler.
# Argument: message ... - String. Optional. Error message
__throwArgument() {
  __throw 2 "$@" || return $?
}

# Run `handler` with an environment error
# Argument: handler - Function. Required. Error handler.
# Argument: message ... - String. Optional. Error message
__throwEnvironment() {
  __throw 1 "$@" || return $?
}

# Run `command`, upon failure run `handler` with an argument error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __throwArgument
__catchArgument() {
  local handler="${1-}"
  shift && "$@" || __throwArgument "$handler" "$@" || return $?
}

# Run `command`, upon failure run `handler` with an environment error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __throwEnvironment
__catchEnvironment() {
  local handler="${1-}"
  shift && "$@" || __throwEnvironment "$handler" "$@" || return $?
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
__throw() {
  local exitCode="${1-}" && shift || returnArgument "Missing exit code" || return $?
  lcoal handler="${1-}" && shift || returnArgument "Missing error handler" || return $?
  "$handler" "$exitCode" "$@" || return $?
}

# Run binary and catch errors with handler
# Argument: handler - Required. Function. Error handler.
# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Requires: returnArgument
__catch() {
  local handler="${1-}" && shift || returnArgument "Missing handler" || return $?
  "$@" || "$handler" "$?" "$@" || return $?
}

# <-- END of IDENTICAL _tinySugar
