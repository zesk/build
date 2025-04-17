#!/bin/bash
#
# Identical template
#
# Original of _errors
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ _errors EOF

# Return `argument` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
# Requires: _return
_environment() {
  _return 1 "$@" || return $?
}
