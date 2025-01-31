#!/usr/bin/env bash
# Type: Directory.
# Location for the build system cache files. Defaults to `$HOME/.build` and if `$HOME` is not a directory then `$(buildHome)/.build`
# Cache MAY be deleted at any time. If you need your files to be preserved, store them elsewhere.
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Build
# Type: Directory
export BUILD_CACHE
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/XDG_CACHE_HOME.sh"
BUILD_CACHE="${BUILD_CACHE-"$XDG_CACHE_HOME/.build"}"
