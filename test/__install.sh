#!/bin/bash
#
# Copy of __install
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL __install 22
set -eou pipefail
# Install, load zesk build and run command
__install() {
  local source="${BASH_SOURCE[0]}"
  local install="bin/install-bin-build.sh"
  local here

  here=$(dirname "$source") || printf "%s\n" "dirname" "$source" 1>&2 && return 99
  if [ ! -d "$here/bin/build" ]; then
    [ -x "$here/$install" ] || printf "%s\n" "$install not executable" 1>&2 && return 98
    "$here/$install" || printf "%s\n" "$install not executable" 1>&2 && return 97
    [ -d "$here/bin/build" ] || printf "%s\n" "$install did not create bin/build" 1>&2 && return 96
  fi
  # shellcheck source=/dev/null
  if source "$here/../bin/build/tools.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'tools.sh: %s\n' "$@"
    return 42 # The meaning of life
  fi
}

__install consoleOrange "$@"
