#!/bin/bash
#
# Identical template
#
# Original of __executeInputSupport
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# General reason for this: `read -t 0` which is the ideal solution does not behave identically
# across platforms to determine if stdin has input. Darwin specifically ignores `-t` when stdin is a pipe or file.
#
# So our hack solution is to read a single byte with a 1-second timeout and then add that into our first line of output
# if needed. Handle the case when the first line is blank (and is a newline)

# _IDENTICAL_ __executeInputSupport EOF

# Support arguments and stdin as arguments to an executor
__executeInputSupport() {
  local usage="$1" executor=() && shift

  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    executor+=("$1")
    shift
  done
  [ ${#executor[@]} -gt 0 ] || return 0

  local byte
  # On Darwin `read -t 0` DOES NOT WORK as a select on stdin
  if [ $# -eq 0 ] && read -r -t 1 -n 1 byte; then
    local line
    if [ "$byte" = $'\n' ]; then
      __catchEnvironment "$usage" "${executor[@]}" "" || return $?
      byte=""
    fi
    while read -r line; do
      __catchEnvironment "$usage" "${executor[@]}" "$byte$line" || return $?
      byte=""
    done
  else
    if [ "$1" = "--" ]; then
      shift
    fi
    __catchEnvironment "$usage" "${executor[@]}" "$@" || return $?
  fi
}
