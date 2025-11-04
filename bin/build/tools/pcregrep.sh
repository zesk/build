#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/pcregrep.md
# Test: ./test/tools/pcregrep-tests.sh

# Install pcregrep binary
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
pcregrepInstall() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchEnvironment "$handler" packageGroupWhich "$(__pcregrepBinary)" pcregrep || return $?
}
_pcregrepInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# The name of the `pcregrep` binary on this operating system
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# stdout: String. Name of binary for pcregrep.
pcregrepBinary() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  __pcregrepBinary
}
_pcregrepBinary() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
