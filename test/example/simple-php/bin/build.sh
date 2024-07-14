#!/bin/bash
#
# Dead simple PHP build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __install 17
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

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
}

__buildSampleApplication() {
  clearLine || return $?
  __environment phpBuild --deployment staging --skip-tag "$@" -- simple.application.php public src docs || return $?
}

__install .. bin __buildSampleApplication "$@"
