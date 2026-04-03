#!/bin/bash
#
# Original of handlerCreate
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL handlerCreate EOF

# Summary: Create a function for error handling automatically
# Argument: handlerFunction - String. Required. Handler function to create if it does not already exist.
handlerCreate() {
  local handler="_${FUNCNAME[0]}"
  local createHandler="${1-}" && shift || throwArgument "$handler" "No handler?" || return $?
  if [ "$(type -t "$createHandler")" != "function" ]; then
    local tt && tt=$(fileTemporaryName "$handler") || return $?
    printf "%s\n" "$createHandler()" "{" $'\t'"bashDocumentation \"\${BASH_SOURCE[0]}\" \"\${FUNCNAME[0]#_}\" \"\$@\"" "}" >"$tt" || returnClean $? "$tt" || return $?
    # shellcheck source=/dev/null
    catchReturn "$handler" source "$tt" || return $?
    rm -f "$tt" || return $?
  fi
}
_handlerCreate() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
