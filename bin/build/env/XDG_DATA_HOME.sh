#!/usr/bin/env bash
# Name: Data Home Directory
# Summary: Data Home Directory
# Base directory for user-specific data to be stored.
# See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# Type: Directory

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/HOME.sh"
set -u # Requires $XDG_DATA_HOME below
export XDG_DATA_HOME
XDG_DATA_HOME=${XDG_DATA_HOME-"$HOME/.local/share"}
