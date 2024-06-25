#!/usr/bin/env bash
#
# identical-repair.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 13
# Load zesk build and run command
__tools() {
  local relative="$1"
  set -eou pipefail
  shift
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/$relative/bin/build/tools.sh"; then
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
  __environment identicalCheckShell --exec consoleError --repair "$BUILD_HOME/bin/build/identical" --singles "$BUILD_HOME/etc/identical-check-singles.txt" "$@" || return $?
}

__tools .. __buildIdenticalRepair "$@"

# EOF
