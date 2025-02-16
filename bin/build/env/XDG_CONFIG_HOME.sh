#!/usr/bin/env bash
# Location for configuration files
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Build Configuration
# Type: Directory
# See: https://specifications.freedesktop.org/basedir-spec/latest/

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/HOME.sh"
set -u # Requires $XDG_DATA_HOME below
export XDG_CONFIG_HOME
XDG_CONFIG_HOME=${XDG_CONFIG_HOME-"$HOME/.config"}
