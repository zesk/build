#!/bin/bash
#
# Copy of _return
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL _return 4
_return() {
  local code
  code="${1-1}" && shift && printf "%s ❌ (%d)\n" "${*-§}" "$code" 1>&2 && return "$code"
}
