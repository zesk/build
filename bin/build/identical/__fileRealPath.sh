#!/bin/bash
#
# Original of fileRealPath
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL fileRealPath EOF

# Find the full, actual path of a file avoiding symlinks or redirection.
# See: readlink realpath
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: file ... - File. Required. One or more files to `realpath`.
# Requires: executableExists realpath __help usageDocument returnArgument
fileRealPath() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __help "$handler" --help || return 0
  if executableExists realpath; then
    realpath "$@"
  else
    local here && here=$(catchReturn "$handler" pwd) && here="${here%/}/" || return $?
    while [ $# -gt 0 ]; do
      if [ -L "$1" ]; then
        readlink "$1"
      elif [ -e "$1" ]; then
        local prefix=""
        [ "${1#/}" != "$1" ] || prefix="$here"
        printf "%s%s\n" "$prefix" "$1"
      else
        throwEnvironment "$handler" "$1 does not exist" || return $?
      fi
      shift
    done
  fi
}
_fileRealPath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
