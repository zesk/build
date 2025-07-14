#!/bin/bash
#
# Original of realPath
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL _realPath EOF

# Usage: realPath argument
# Argument: file ... - Required. File. One or more files to `realpath`.
# Requires: whichExists realpath __help usageDocument _argument
realPath() {
  [ "${1-}" != "--help" ] || __help "$_${FUNCNAME[0]}" "$@" || return 0
  [ -e "$1" ] || _argument "Not a file: $1" || return $?
  if whichExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}
_realPath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
