#!/usr/bin/env bash
# Location for the build system cache directory
# Defaults to `$HOME/.build` and if `$HOME` is not a directory then `./.build`
# Copyright &copy; 2024 Market Acumen, Inc.
# Category: Build
export BUILD_CACHE
if [ -z "${BUILD_CACHE-}" ]; then
  _BUILD_CACHE_DEFAULT() {
    local useDir
    export HOME BUILD_HOME

    # Do not use buildEnvironmentLoad
    # shellcheck source=/dev/null
    source "${BUILD_HOME:-.}/bin/build/env/HOME.sh" || :
    useDir="${HOME-}"
    if [ ! -d "$useDir" ]; then
      # Should be application home
      if ! useDir="$(pwd -P 2>/dev/null)"; then
        decorate error "Unable to pwd" 1>&2
        return 1
      fi
    fi
    printf "%s/%s\n" "${useDir%%/}" ".build"
  }
  BUILD_CACHE="${BUILD_CACHE:-"$(_BUILD_CACHE_DEFAULT)"}"
  unset _BUILD_CACHE_DEFAULT || :
fi
