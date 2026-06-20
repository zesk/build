#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# fn: decorate size
# Summary: Size converted to kilo, mega, giga bytes.
# Argument: size - UnsignedInteger. Optional. Size to display.
# Example:     > decorate size 169204
# Example:     165k (169204)
# Example:     > decorate size 16920400232
# Example:     15G (16920400232)
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
