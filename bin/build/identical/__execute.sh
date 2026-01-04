#!/bin/bash
#
# Identical template
#
# Original of execute
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# _IDENTICAL_ execute EOF

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: returnMessage
execute() {
  "$@" || returnMessage "$?" "$@" || return $?
}
