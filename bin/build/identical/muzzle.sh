#!/usr/bin/env bash
# IDENTICAL templateHeader 7
#
# Identical template
#
# Original of muzzle
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL muzzle EOF

# Suppress stdout without piping. Handy when you just want a behavior not the output.
# Argument: command - Callable. Required. Thing to muzzle.
# Argument: ... - Arguments. Optional. Additional arguments.
# Example:     {fn} pushd "$buildDir"
# Example:     catchEnvironment "$handler" phpBuild || returnUndo $? {fn} popd || return $?
# stdout: - No output from stdout ever from this function
muzzle() {
  # __IDENTICAL__ __checkHelp1FUNCNAME 1
  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
  "$@" >/dev/null
}
_muzzle() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
