#!/bin/bash
#
# Copy of _clearLine
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL _clearLine 5
# Simple blank line generator for scripts
_clearLine() {
  local width
  read -d' ' -r width < <(stty size) || width=80 && printf "\r%s\r" "$(seq -s' ' "$((width + 1))" | sed 's/[0-9]//g')"
}
