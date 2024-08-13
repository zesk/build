#!/usr/bin/env bash
#
# EDIT THIS FILE
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Minimum _sugar for install
# Requires IDENTICAL: _return
#

# IDENTICAL _tinySugar EOF
# Error codes
_code() {
  case "${1-}" in *nvironment) printf 1 ;; *rgument) printf 2 ;; *) printf 126 ;; esac
}

# Usage: {fn} usage message
__failArgument() {
  local usage="${1-}"
  shift && "$usage" "$(_code argument)" "$@" || return $?
}

# Usage: {fn} usage message
__failEnvironment() {
  local usage="${1-}"
  shift && "$usage" "$(_code environment)" "$@" || return $?
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
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# Usage: {fn} exitCode itemToDelete ...
_clean() {
  local r="${1-}" && shift && rm -rf "$@"
  return "$r"
}
