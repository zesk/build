#!/bin/bash
#
# Copy of __ops
#
#
# requires IDENTICAL _return
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __ops EOF
# Load zesk ops and run command
__ops() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/ops.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}
