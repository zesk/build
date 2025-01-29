#!/bin/bash
#
# Identical template
#
# Original of _clearLine
#
# Copyright &copy; 2025 Market Acumen, Inc.

# IDENTICAL _clearLine EOF

# Simple blank line generator for scripts
# Usage: {fn}
# Requires: read stty printf seq sed
_clearLine() {
  local width
  read -d' ' -r width < <(stty size) || width=80 && printf "\r%s\r" "$(seq -s' ' "$((width + 1))" | sed 's/[0-9]//g')"
}
