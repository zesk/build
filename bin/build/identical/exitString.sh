#!/bin/bash
#
# Identical template
#
# Original of exitString
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ exitString EOF

# Output the exit code as a string
# Winner of the one-line bash award 10 years running
# Argument: code ... - UnsignedInteger. Required. Exit code value to output.
# stdout: exitCodeToken, one per line
exitString() {
  local k="" && while [ $# -gt 0 ]; do case "$1" in 1) k="environment" ;; 2) k="argument" ;; 97) k="assert" ;; 105) k="identical" ;; 108) k="leak" ;; 116) k="timeout" ;; 120) k="exit" ;; 253) k="internal" ;; 254) k="unknown" ;; *) k="[exitString unknown \"$1\"]" ;; esac && [ -n "$k" ] || k="$1" && printf "%s\n" "$k" && shift; done
}
