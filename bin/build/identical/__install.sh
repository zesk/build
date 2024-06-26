#!/bin/bash
#
# Copy of __install
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL __install 18
# Install, load zesk build and run command
__install() {
  local relative="$1" installPath="$2"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift 2 && set -eou pipefail
  local install="$here/$installPath/install-bin-build.sh"
  local tools="$here/$relative/bin/build/tools.sh"
  if [ ! -d "$here/build" ]; then
    [ -x "$install" ] || _return 99 "$install not executable" || return $?
    "$install" || _return 98 "$install failed" || return $?
  fi
  [ -x "$tools" ] || _return 97 "$install failed to create $tools" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

# requires _return

# __install ../../.. bin/build consoleOrange "$@"
