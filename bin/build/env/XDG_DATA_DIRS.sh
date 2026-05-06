#!/usr/bin/env bash
# Name: Data Path Directories
# Summary: Data Path Directories
# Search directory for user-specific data files to be stored. `:` separated.
# Type: DirectoryList
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/XDG_DATA_HOME.sh"
export XDG_DATA_DIRS
XDG_DATA_DIRS=${XDG_DATA_DIRS-"${XDG_DATA_HOME-}"}
