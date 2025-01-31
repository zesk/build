#!/usr/bin/env bash
# Base directory for user-specific data to be stored
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Configuration
# Type: Directory
# See: https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_DATA_HOME
XDG_DATA_HOME=${XDG_DATA_HOME-"$HOME/.local/share"}
