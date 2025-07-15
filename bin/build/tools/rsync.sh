#!/usr/bin/env bash
#
# rsync Tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/rsync.md
# Test: ./test/tools/rsync-tests.sh

# Install `rsync`.
#
# `rsync` is a tool which easily keeps file directories synchronized between
# file systems, remote systems, and locations.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
rsyncInstall() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
  packageWhich rsync
}
_rsyncInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
