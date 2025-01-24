#!/bin/bash
#
# Original of realPath
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL _realPath EOF
# Usage: realPath argument
# Argument: file ... - Required. File. One or more files to `realpath`.
# Requires: whichExists realpath
realPath() {
  # realpath is not present always
  if whichExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}
