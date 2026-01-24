#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# fn: decorate size
# Argument: size - UnsignedInteger. Optional. Size to display.
# Mostly $ and " are problematic within a string
# Requires: printf decorate isUnsignedInteger
__decorateExtensionSize() {
  while [ $# -gt 0 ]; do
    local size="$1"

    # Skip any `--`
    [ "$size" != "--" ] || continue

    if isUnsignedInteger "$size"; then
      if [ "$size" -lt 4096 ]; then
        printf "%db\n" "$size"
      elif [ "$size" -lt 4194304 ]; then
        printf "%dk (%d)\n" "$((size / 1024))" "$size"
      elif [ "$size" -lt 4294967296 ]; then
        printf "%dM (%d)\n" "$((size / 1048576))" "$size"
      else
        printf "%dG (%d)\n" "$((size / 1073741824))" "$size"
      fi
    else
      printf "%s\n" "[SIZE $size]"
    fi
    shift
  done
}
