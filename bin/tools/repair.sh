#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Run repair on profile-related tokens
repairProfile() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  catchReturn "$handler" "$home/bin/build/repair.sh" profileFunctionMarker profileFunctionMarkerOthers profileFunctionTail profileFunctionHead profileFunctionEnable || return $?
}
_repairProfile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
