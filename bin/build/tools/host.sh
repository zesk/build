#!/usr/bin/env bash
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/host.md
# Test: ./test/tools/host-tests.sh
#
# host in this context means system host

# Get the full hostname
# Requires: __help __hostname usageRequireBinary __usageEnvironment
hostnameFull() {
  local usage="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
  __usageEnvironment "$usage" __hostname || return $?
}
_hostnameFull() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
