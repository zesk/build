#!/bin/bash
#
# Identical template
#
# Original of __execute
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ __execute EOF

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}
