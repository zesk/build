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
# Usage: {fn} usage message
__failArgument() {
  local usage="${1-}"
  shift && "$usage" 2 "$@" || return $?
}

# Usage: {fn} usage message
__failEnvironment() {
  local usage="${1-}"
  shift && "$usage" 1 "$@" || return $?
}

# Usage: {fn} usage command
__usageArgument() {
  local usage="${1-}"
  shift && "$@" || __failArgument "$usage" "$@" || return $?
}

# Usage: {fn} usage command
__usageEnvironment() {
  local usage="${1-}"
  shift && "$@" || __failEnvironment "$usage" "$@" || return $?
}

# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return 2 "$@" || return $?
}

# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return 1 "$@" || return $?
}

# Usage: {fn} exitCode itemToDelete ...
_clean() {
  local r="${1-}" && shift && rm -rf "$@"
  return "$r"
}
