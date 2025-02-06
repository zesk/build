#!/usr/bin/env bash
# Cached value of the availability of /dev/tty
# true or false
# true - /dev/tty appears to be operating without errors
# false - /dev/tty appears to be disconnected and can not be used
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Operating System
# Type: Boolean
export __BUILD_HAS_TTY
__BUILD_HAS_TTY=${__BUILD_HAS_TTY-}
