#!/usr/bin/env bash
# Search directory for user-specific configuration files to be stored. `:` separated.
# Type: DirectoryList
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Configuration
# See: https://specifications.freedesktop.org/basedir-spec/latest/

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/XDG_CONFIG_HOME.sh"
export XDG_CONFIG_DIRS
XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS-"${XDG_CONFIG_HOME-}"}
