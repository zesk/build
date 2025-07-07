#!/usr/bin/env bash
#
# Floating-point support
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: printf
# Docs: contextOpen ./documentation/source/tools/float.md
# Test: contextOpen ./test/tools/float-tests.sh

# Usage: {fn} float
# Convert float to nearest integer
floatRound() {
  while [ $# -gt 0 ]; do
    LC_ALL=C printf '%.0f' "$1"
    shift || :
  done
}

# Usage: {fn} float
# Convert float to an integer, round down always
floatTruncate() {
  while [ $# -gt 0 ]; do
    LC_ALL=C printf '%d\n' "${1%.*}"
    shift || :
  done
}
