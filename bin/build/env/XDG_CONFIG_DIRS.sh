#!/usr/bin/env bash
# Name: Configuration Path Directories
# Summary: Configuration Path Directories
# Search directory for user-specific configuration files to be stored. `:` separated.
# Type: DirectoryList
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/XDG_CONFIG_HOME.sh"
export XDG_CONFIG_DIRS
XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS-"${XDG_CONFIG_HOME-}"}
