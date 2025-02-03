#!/usr/bin/env bash
# Base directory for user-specific cache data to be stored
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Configuration
# Type: Directory
# See: https://specifications.freedesktop.org/basedir-spec/latest/
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/HOME.sh"
export XDG_CACHE_HOME
XDG_CACHE_HOME=${XDG_DATA_HOME-"${HOME-}/.cache"}
