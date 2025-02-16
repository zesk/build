#!/usr/bin/env bash
# Cached value of the availability of /dev/tty
# true or false
# true - /dev/tty appears to be operating without errors
# false - /dev/tty appears to be disconnected and can not be used
# This value is set automatically by `isTTYAvailable` and caches the value to avoid testing again.
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Internal
# Type: Boolean
export __BUILD_HAS_TTY
__BUILD_HAS_TTY=${__BUILD_HAS_TTY-}
