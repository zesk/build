#!/bin/bash
#
# Identical template
#
# Original of usageDocument
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL bashFunctionComment EOF
# Extract a bash comment from a file
# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# Notes: Keep this free of any extraneous dependencies
# Requires: grep cut reverseFileLines
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  grep -m 1 -B $maxLines "$functionName() {" "$source" | grep -v -e '( IDENTICAL | _IDENTICAL_ |DOC TEMPLATE:|Internal:)' |
    reverseFileLines | grep -B "$maxLines" -m 1 -E '^\s*$' |
    reverseFileLines | grep -E '^#' | cut -c 3-
}
