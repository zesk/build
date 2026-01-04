#!/usr/bin/env bash
#
# Floating-point support
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# bin: printf
# Docs: contextOpen ./documentation/source/tools/float.md
# Test: contextOpen ./test/tools/float-tests.sh

# Argument: number - Float. Optional. Floating point number to convert to integer.
# Convert float to nearest integer (up or down)
floatRound() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    LC_ALL=C printf '%.0f' "$1"
    shift || :
  done
}
_floatRound() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: number - Float. Optional. Floating point number to convert to integer.
# Convert float to an integer, round down always
floatTruncate() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    LC_ALL=C printf '%d\n' "${1%.*}"
    shift || :
  done
}
_floatTruncate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
