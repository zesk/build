#!/usr/bin/env bash
#
# identical-repair.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

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

__buildIdenticalRepair() {
  export BUILD_HOME
  __environment buildEnvironmentLoad BUILD_HOME || return $?
  __environment cd "$BUILD_HOME" || return $?
  __environment identicalCheckShell --repair "$BUILD_HOME/bin/build/identical" --singles "$BUILD_HOME/etc/identical-check-singles.txt" "$@" || return $?
}

__ops .. __buildIdenticalRepair "$@"

# EOF
