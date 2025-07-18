#!/usr/bin/env bash
#
# Patched version of isExecutable (other one works around a Docker bug)
#
# Use this when we can!
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Test if all arguments are executable binaries
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - All arguments are executable binaries
# Exit code: 1 - One or or more arguments are not executable binaries
# Requires: isExecutableHack
isExecutable() {
  isExecutableHack "$@"
}

# fn: isExecutable*
# Test if all arguments are executable binaries
#
# a.k.a. isExecutableHack - this version is slow and works around a bug in Docker's mapped volumes.
#
# Usage: {fn} string0 [ string1 ... ]
# Argument: string - Required. Path to binary to test if it is executable.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - All arguments are executable binaries
# Exit code: 1 - One or or more arguments are not executable binaries
# Workaround: On Mac OS X the Docker environment thinks non-executable files are executable, notably `bin/build/README.md` is considered `[ -x $file ]` when you are inside the container when the directory is mapped from the operating system. If it's a non-mapped directory, it works fine. Seems to be a bug in how permissions are translated, I assume. Workaround falls.
# Requires: _argument which ls awk
isExecutableHack() {
  local lsMask

  [ $# -eq 1 ] || _argument "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  if [ -f "$1" ]; then
    # FAILS on plain files in docker on Mac OS X
    if [ ! -x "$1" ]; then
      return 1
    fi
    # shellcheck disable=SC2012
    if lsMask="$(ls -lhaF "$1" | awk '{ print $1 }')"; then
      if [ "$lsMask" = "${lsMask%%x*}" ]; then
        return 1
      fi
    fi
  elif [ -z "$(which "$1")" ]; then
    return 1
  fi
  return 0
}
_isExecutableHack() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
