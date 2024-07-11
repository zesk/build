#!/bin/bash
#
# Copy of __return
#
#
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __return 7
# Usage: {fn} __return binary [ ... ]
# Argument: binary - Required. Executable.
# Argument: ... - Any arguments are passed to binary
# Run binary and output failed command upon error
__return() {
  "$@" || _return "$?" "$@" || return $?
}
