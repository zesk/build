#!/usr/bin/env bash
#
# Typeless languages make coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.

# ------------------------------- CUT BELOW HERE -------------------------------

# IDENTICAL isCallable EOF

# Test if all arguments are callable as a command
# handler: {fn} string0 [ string1 ... ]
# Argument: string - Required. EmptyString. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - All arguments are callable as a command
# Return Code: 1 - One or or more arguments are callable as a command
# Requires: throwArgument __help isExecutable isFunction
isCallable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || throwArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if ! isFunction "$1" && ! isExecutable "$1"; then
    return 1
  fi
}
_isCallable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if all arguments are executable binaries
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Return Code: 0 - All arguments are executable binaries
# Return Code: 1 - One or or more arguments are not executable binaries
# Requires: throwArgument __help which
isExecutable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || throwArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  if [ -f "$1" ]; then
    local mode
    # Docker has an issue when you mount a local volume inside a container
    # Executable files, inside the container within the mounted volume report as non-executable via `-x` but
    # Report *correctly* when you use `ls`.
    mode=$(catchEnvironment "$handler" ls -l "$1" | awk '{ print $1 }') || return $?
    [ "${mode#*x}" != "$mode" ]
  else
    [ -n "$(command which "$1")" ]
  fi
}
_isExecutable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
