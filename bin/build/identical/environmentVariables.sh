#!/bin/bash
#
# Original of environmentVariables
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL environmentVariables EOF

#
# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Requires: declare grep cut
environmentVariables() {
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}
