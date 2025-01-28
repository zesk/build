#!/bin/bash
#
# Identical template
#
# Original of __execute
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ __execute EOF

# Usage: {fn} __execute binary [ ... ]
# Argument: binary - Required. Executable.
# Argument: ... - Any arguments are passed to binary
# Run binary and output failed command upon error
# Requires: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}
