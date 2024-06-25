#!/bin/bash
#
# Copy of __tools
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL __tools 11
# Load zesk build and run command
__tools() {
  set -eou pipefail
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
}
