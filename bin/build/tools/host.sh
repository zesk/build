#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Test: ./test/tools/host-tests.sh
#
# host in this context means system host

# Summary: Platform-agnostic host name
# Get the full hostname on the current platform.
# Formerly `hostname``Full`.
# Requires: helpArgument __hostname executableRequire catchEnvironment
networkNameFull() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchReturn "$handler" __hostname || return $?
}
_networkNameFull() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
