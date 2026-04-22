#!/usr/bin/env bash
#
# Typeless languages make coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2026 Market Acumen, Inc.

# ------------------------------- CUT BELOW HERE -------------------------------

# IDENTICAL isCallable EOF

# Test if all arguments are callable as a command
# Argument: string - EmptyString. Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - All arguments are callable as a command
# Return Code: 1 - One or or more arguments are callable as a command
# Requires: throwArgument helpArgument isExecutable isFunction
isCallable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || throwArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  if ! isFunction "$1" && ! isExecutable "$1"; then
    return 1
  fi
}
_isCallable() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if all arguments are executable binaries
# Argument: string - String. Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - All arguments are executable binaries
# Return Code: 1 - One or or more arguments are not executable binaries
# Requires: throwArgument  helpArgument type
# Environment: PATH
isExecutable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || throwArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  if [ "${1#/}" != "$1" ] && [ -f "$1" ]; then
    [ -x "$1" ]
  else
    muzzle type -P "$1"
  fi
}
_isExecutable() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
