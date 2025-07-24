#!/usr/bin/env bash
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/host.md
# Test: ./test/tools/host-tests.sh
#
# host in this context means system host

# Get the full hostname
# Requires: __help __hostname usageRequireBinary __catchEnvironment
hostnameFull() {
  local usage="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"
  __catch "$usage" __hostname || return $?
}
_hostnameFull() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
