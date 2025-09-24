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
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Return Code: 1
# Requires: _return
_environment() {
  _return 1 "$@" || return $?
}

# Run `handler` with an argument error
# Argument: exitCode - Integer. Required. Return code.
# Argument: handler - Function. Required. Error handler.
# Argument: message ... - String. Optional. Error message
# Requires: _argument
__throw() {
  local exitCode="${1-}" && shift || _argument "Missing exit code" || return $?
  lcoal handler="${1-}" && shift || _argument "Missing error handler" || return $?
  "$handler" "$exitCode" "$@" || return $?
}

# Run binary and catch errors with handler
# Argument: handler - Required. Function. Error handler.
# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Requires: _argument
__catch() {
  local handler="${1-}" && shift || _argument "Missing handler" || return $?
  "$@" || "$handler" "$?" "$@" || return $?
}
