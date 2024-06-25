#!/bin/bash
#
# Copy of __install
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL _return 8
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}"
  shift
  printf "%s ❌ (%d)\n" "${*-§}" "$code" 1>&2
  return "$code"
}

# IDENTICAL __install 17
# Install, load zesk build and run command
__install() {
  local source="${BASH_SOURCE[0]}"
  local install="bin/install-bin-build.sh"
  local here

  set -eou pipefail
  here=$(dirname "$source") || _return 99 dirname "$source" || return $?
  if [ ! -d "$here/build" ]; then
    [ -x "$here/$install" ] || _return 98 "$here/$install not executable" || return $?
    "$here/$install" || _return 97 "$install not executable" || return $?
    [ -d "$here/build" ] || _return 96 "$install did not create $here/build" || return $?
  fi
  # shellcheck source=/dev/null
  source "$here/../bin/build/tools.sh" || _return 42 tools.sh "$@" || return $?
  "$@" || return $?
}

__install consoleOrange "$@"
