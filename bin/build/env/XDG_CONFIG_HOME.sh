#!/usr/bin/env bash
# Location for configuration files
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Configuration
# Type: Directory
# See: https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_CONFIG_HOME
XDG_CONFIG_HOME=${XDG_CONFIG_HOME-"$HOME/.config"}
