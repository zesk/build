#!/bin/bash
#
# Original of __return
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __return EOF
# Usage: {fn} __return binary [ ... ]
# Argument: binary - Required. Executable.
# Argument: ... - Any arguments are passed to binary
# Run binary and output failed command upon error
__return() {
  [ $# -gt 0 ] || _argument "${FUNCNAME[0]} no arguments $(debuggingStack -s)" || return $?
  "$@" || _return "$?" "$@" || return $?
}
