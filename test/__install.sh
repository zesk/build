#!/bin/bash
#
# Copy of __install
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL __install 21
set -eou pipefail
# Install, load zesk build and run command
_return() {
  local code
  code="${1-0}" && exec 1>&2 && shift && printf "%s -> %d\n" "$(printf "%s " "$@")" "$code" && return "$code"
}
__install() {
  local source="${BASH_SOURCE[0]}"
  local install="bin/install-bin-build.sh"
  local here

  here=$(dirname "$source") || _return 99 dirname "$source" || return $?
  if [ ! -d "$here/bin/build" ]; then
    [ -x "$here/$install" ] || _return 98 "$install not executable" || return $?
    "$here/$install" || _return 97 "$install not executable" || return $?
    [ -d "$here/bin/build" ] || _return 96 "$install did not create bin/build" || return $?
  fi
  # shellcheck source=/dev/null
  source "$here/../bin/build/tools.sh" || _return 42 tools.sh "$@" || return $?
  "$@" || return $?
}

__install consoleOrange "$@"
