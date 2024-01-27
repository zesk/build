#!/usr/bin/env bash
# Location for the build system cache directory
# Defaults to `$HOME/.build` and if `$HOME` is not a directory then `./.build`
# Copyright &copy; 2024 Market Acumen, Inc.
export BUILD_CACHE
_BUILD_CACHE_DEFAULT() {
  local useDir
  # shellcheck source=/dev/null
  source "$(dirname "${BASH_SOURCE[0]}")/../env/HOME.sh"
  useDir="$HOME"
  if [ ! -d "$useDir" ]; then
    # Should be application home
    useDir="$(pwd)"
  fi
  printf "%s/%s\n" "${useDir%%/}" ".build"
}
BUILD_CACHE="${BUILD_CACHE-"$(_BUILD_CACHE_DEFAULT)"}"
