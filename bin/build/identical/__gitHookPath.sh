#!/bin/bash
#
# Identical template
#
# Original of __where
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __gitHookPath EOF

# Summary: Locates application home depending on whether this is running as a git hook or not
# Usage: {fn}
# If current path contains `.git/` then print `../../..` otherwise print `../..`
# Lets us know if default hooks are in starting directory or are running as a git hook
# Requires: printf
__gitHookPath() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}/"
  [ "${here%%.git/*}" != "$here" ] || printf "%s" "../"
  printf "%s" "../.."
}
