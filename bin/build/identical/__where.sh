#!/bin/bash
#
# Copy of __where
#
# Copyright &copy; 2024 Market Acumen, Inc.


# IDENTICAL __where 7
# Locates bin/build depending on whether this is running as a git hook or not
__where() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  [ "${here%%.git*}" != "$here" ] || printf "%s" "../"
  printf "%s" "../.."
}
