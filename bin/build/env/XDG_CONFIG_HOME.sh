#!/usr/bin/env bash
# Name: Main Configuration Path
# Summary: Main Configuration Path
# Location for configuration files
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# Type: Directory
# See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/HOME.sh"
set -u # Requires $XDG_DATA_HOME below
export XDG_CONFIG_HOME
XDG_CONFIG_HOME=${XDG_CONFIG_HOME-"$HOME/.config"}
