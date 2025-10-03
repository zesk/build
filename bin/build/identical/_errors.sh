#!/bin/bash
#
# Identical template
#
# Original of _errors
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ _errors EOF

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
