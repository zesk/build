#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# fn: decorate pair
# Summary: Output a name value pair (decorate extension)
#
# The name is output left-aligned to the `characterWidth` given and colored using `decorate label`; the value colored using `decorate value`.
#
# Argument: characterWidth - UnsignedInteger. Optional. Number of characters to format the value for spacing. Uses environment variable BUILD_PAIR_WIDTH if not set.
# Argument: name - String. Required. Name to output
# Argument: value ... - String. Optional. One or more Values to output as values for `name` (single line)
# Environment: BUILD_PAIR_WIDTH
# shellcheck disable=SC2120
__decorateExtensionPair() {
  local width="" name
  if isUnsignedInteger "${1-}"; then
    width="$1" && shift
  fi
  if [ -z "$width" ]; then
    export BUILD_PAIR_WIDTH
    width=${BUILD_PAIR_WIDTH-}
    isUnsignedInteger "$width" || width=40
  fi
  name="${1-}"
  shift 2>/dev/null || :
  if [ -z "$name" ]; then
    return 0
  fi
  printf "%s %s%s\n" "$(decorate label "$(textAlignLeft "$width" "$name")")" "$(decorate each -- value "$@")" "$(decorate reset --)"
}
