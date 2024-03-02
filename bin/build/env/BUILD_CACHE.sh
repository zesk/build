#!/usr/bin/env bash
# Location for the build system cache directory
# Defaults to `$HOME/.build` and if `$HOME` is not a directory then `./.build`
# Copyright &copy; 2024 Market Acumen, Inc.
export BUILD_CACHE
_BUILD_CACHE_DEFAULT() {
  local useDir
  export HOME

  # shellcheck source=/dev/null
  source "${BUILD_HOME:-.}/bin/build/env/HOME.sh" || :
  useDir="${HOME-}"
  if [ ! -d "$useDir" ]; then
    # Should be application home
    if ! useDir="$(pwd -P 2>/dev/null)"; then
      consoleError "Unable to pwd" 1>&2
      return 1
    fi
  fi
  printf "%s/%s\n" "${useDir%%/}" ".build"
}
BUILD_CACHE="${BUILD_CACHE:-"$(_BUILD_CACHE_DEFAULT)"}"
