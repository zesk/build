#!/usr/bin/env bash
# Name: State Home Directory
# Summary: State Home Directory
# Base directory for user-specific state files to be stored
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.
# Type: Directory
export XDG_STATE_HOME
XDG_STATE_HOME=${XDG_STATE_HOME-"$HOME/.local/state"}
