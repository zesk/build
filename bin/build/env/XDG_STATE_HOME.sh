#!/usr/bin/env bash
# Base directory for user-specific state files to be stored
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Configuration
# See: https://specifications.freedesktop.org/basedir-spec/latest/
# Type: Directory
export XDG_STATE_HOME
XDG_STATE_HOME=${XDG_STATE_HOME-"$HOME/.local/state"}
