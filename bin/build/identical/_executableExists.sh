#!/bin/bash
#
# Original of executableExists
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL executableExists EOF

# Summary: Does a binary exist in the PATH?
# Argument: --any - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist.
# Argument: binary ... - String. Required. One or more Binaries to find in the system `PATH`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 0 - If all values are found (without the `--any` flag), or if *any* binary is found with the `--any` flag
# Return Code: 1 - If any value is not found (without the `--any` flag), or if *all* binaries are NOT found with the `--any` flag.
# Example:     executableExists cp date aws ls mv stat || throwEnvironment "$handler" "Need basic environment to work" || return $?
# Example:     executableExists --any terraform tofu || throwEnvironment "$handler" "No available infrastructure providers" || return $?
# Example:     executableExists --any curl wget || throwEnvironment "$handler" "No way to download URLs easily" || return $?
# Requires: throwArgument decorate __decorateExtensionEach command
executableExists() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$# anyFlag=false
  [ $# -gt 0 ] || throwArgument "$handler" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --any) anyFlag=true ;;
    *)
      local bin
      # printf is returned as just printf with no path, same with all builtins
      bin=$(command -v "$1" 2>/dev/null) || return 1
      [ -n "$bin" ] || return 1
      [ "${bin:0:1}" != "/" ] || [ -e "$bin" ] || return 1
      ! $anyFlag || return 0
      ;;
    esac
    shift
  done
}
_executableExists() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
