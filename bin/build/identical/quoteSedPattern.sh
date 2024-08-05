#!/bin/bash
#
# Original of quoteSedPattern
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL quoteSedPattern EOF

# Summary: Quote sed strings for shell use
# Quote a string to be used in a sed pattern on the command line.
# Usage: quoteSedPattern text
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
#
quoteSedPattern() {
  value=$(printf "%s\n" "$1" | sed 's/\([\\.*+?]\)/\\\1/g')
  value="${value//\//\\/}"
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//&/\\&}"
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}
