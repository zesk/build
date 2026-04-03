#!/bin/bash
#
# Original of environmentVariables
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL environmentVariables EOF

# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Requires: declare grep cut bashDocumentation __help
environmentVariables() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  {
    declare -px | grep 'declare -x ' | cut -f 1 -d "=" | cut -f 3 -d " " && declare -ax | grep 'declare -ax ' | cut -f 1 -d '=' | cut -f 3 -d " "
  } | catchReturn "$handler" sort -u || return $?
}
_environmentVariables() {
  true || environmentVariables --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
