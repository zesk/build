#!/bin/bash
#
# Identical template
#
# Original of fileReverseLines
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL fileReverseLines EOF

# Reverses a pipe's input lines to output using an awk trick.
#
# Not recommended on big files.
#
# Summary: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
# Depends: awk
fileReverseLines() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}
_fileReverseLines() {
  true || fileReverseLines --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
