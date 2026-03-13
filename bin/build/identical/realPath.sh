#!/bin/bash
#
# Original of fileRealPath
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL _fileRealPath EOF

# Find the full, actual path of a file avoiding symlinks or redirection.
# See: readlink realpath
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: file ... - File. Required. One or more files to `realpath`.
# Requires: executableExists realpath __help usageDocument returnArgument
fileRealPath() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  if executableExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}
_fileRealPath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
