#!/bin/bash
#
# Copy of __ops
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL __ops 13
# Load zesk build and run command
__ops() {
  local relative="$1"
  set -eou pipefail
  shift
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/$relative/bin/build/ops.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
}
