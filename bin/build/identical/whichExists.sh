#!/bin/bash
#
# Original of whichExists
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL whichExists EOF

# Argument: binary ... - Required. String. One or more Binaries to find in the system `PATH`.
# Exit code: 0 - If all values are found
# Exit code: 1 - If any value is not found
# Requires: __throwArgument which decorate __decorateExtensionEach
whichExists() {
  local usage="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  [ $# -gt 0 ] || __throwArgument "$usage" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || __throwArgument "$usage" "blank argument #$((__count - $# + 1)) ($(decorate each code "${__saved[@]}"))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}
_whichExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
