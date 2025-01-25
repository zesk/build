#!/usr/bin/env bash
#
# When you only need a little bit of syntactic sugar
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Minimum _sugar for install
# Requires IDENTICAL: _return
#

# IDENTICAL _tinySugar EOF

# Run `usage` with an argument error
# Usage: {fn} usage ...
__throwArgument() {
  local usage="${1-}"
  shift && "$usage" 2 "$@" || return $?
}

# Run `usage` with an environment error
# Usage: {fn} usage ...
__throwEnvironment() {
  local usage="${1-}"
  shift && "$usage" 1 "$@" || return $?
}

# Run `command`, upon failure run `usage` with an argument error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __throwArgument
__catchArgument() {
  local usage="${1-}"
  shift && "$@" || __throwArgument "$usage" "$@" || return $?
}

# Run `command`, upon failure run `usage` with an environment error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __throwEnvironment
__catchEnvironment() {
  local usage="${1-}"
  shift && "$@" || __throwEnvironment "$usage" "$@" || return $?
}

# Return `argument` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
# Requires: _return
_environment() {
  _return 1 "$@" || return $?
}

# Usage: {fn} exitCode item ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: rm
_clean() {
  local r="${1-}" && shift && rm -rf "$@"
  return "$r"
}
