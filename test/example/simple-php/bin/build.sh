#!/bin/bash
#
# Dead simple PHP build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

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
  if [ ! -d "$here/build" ]; then
    [ -x "$here/$install" ] || _return 98 "$here/$install not executable" || return $?
    "$here/$install" || _return 97 "$install not executable" || return $?
    [ -d "$here/build" ] || _return 96 "$install did not create $here/build" || return $?
  fi
  # shellcheck source=/dev/null
  source "$here/../bin/build/tools.sh" || _return 42 tools.sh "$@" || return $?
  "$@" || return $?
}

buildSampleApplication() {
  clearLine || return $?
  __environment phpBuild --deployment staging --skip-tag "$@" -- simple.application.php public src docs || return $?
}

__install buildSampleApplication "$@"
