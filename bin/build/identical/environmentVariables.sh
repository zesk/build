#!/bin/bash
#
# Original of environmentVariables
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL environmentVariables EOF

# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Requires: declare grep cut usageDocument __help
environmentVariables() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}
_environmentVariables() {
  true || environmentVariables --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
