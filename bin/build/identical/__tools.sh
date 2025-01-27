#!/bin/bash
#
# Identical template
#
# Original of __tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# IDENTICAL __tools EOF

# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}
