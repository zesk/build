#!/bin/bash
#
# Original of realPath
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL _realPath EOF

# Find the full, actual path of a file avoiding symlinks or redirection.
# See: readlink realpath
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: file ... - Required. File. One or more files to `realpath`.
# Requires: whichExists realpath __help usageDocument _argument
realPath() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
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
