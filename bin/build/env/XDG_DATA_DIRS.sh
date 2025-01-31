#!/usr/bin/env bash
# Search directory for user-specific data files to be stored. `:` separated.
# Type: DirectoryList
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Configuration
# See: https://specifications.freedesktop.org/basedir-spec/latest/

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/XDG_DATA_HOME.sh"
export XDG_DATA_DIRS
XDG_DATA_DIRS=${XDG_DATA_DIRS-"${XDG_DATA_HOME-}"}
