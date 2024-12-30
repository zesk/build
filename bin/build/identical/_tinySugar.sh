#!/usr/bin/env bash
#
# When you only need a little bit of syntactic sugar
#
# EDIT THIS FILE
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Minimum _sugar for install
# Requires IDENTICAL: _return
#

# IDENTICAL _tinySugar EOF
# Run `usage` with an argument error
# Usage: {fn} usage ...
__failArgument() {
  local usage="${1-}"
  shift && "$usage" 2 "$@" || return $?
}

# Run `usage` with an environment error
# Usage: {fn} usage ...
__failEnvironment() {
  local usage="${1-}"
  shift && "$usage" 1 "$@" || return $?
}

# Run `command`, upon failure run `usage` with an argument error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
__usageArgument() {
  local usage="${1-}"
  shift && "$@" || __failArgument "$usage" "$@" || return $?
}

# Run `command`, upon failure run `usage` with an environment error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
__usageEnvironment() {
  local usage="${1-}"
  shift && "$@" || __failEnvironment "$usage" "$@" || return $?
}

# Return `argument` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return 1 "$@" || return $?
}

# Usage: {fn} exitCode item ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
_clean() {
  local r="${1-}" && shift && rm -rf "$@"
  return "$r"
}
