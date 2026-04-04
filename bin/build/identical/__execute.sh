#!/bin/bash
#
# Identical template
#
# Original of execute
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# _IDENTICAL_ execute EOF

# Argument: --help - Flag. Optional. Display this help.
# Argument: binary - Callable. Required. Command to run.
# Argument: ... - Arguments. Optional. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: returnMessage __help
execute() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  "$@" || returnMessage "$?" "$@" || return $?
}
