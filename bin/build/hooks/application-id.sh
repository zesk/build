#!/usr/bin/env bash
#
# Fetch an ID which represents the current application build/code state which is unique
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"
# fn: {base}
# Usage: {fn}
#
# Generate a unique ID for the state of the application files
#
# The default hook uses the short git sha:
#
#     git rev-parse --short HEAD
#
# Example:     885acc3
#
__hookApplicationChecksum() {
  local usage="_${FUNCNAME[0]}"
  local home argument

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        __failArgument "$usage" "unknown argument: $argument" || return $?
        ;;
    esac
    shift || :
  done
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  if ! home="$(gitFindHome "$home" 2>/dev/null)" || [ -z "$home" ]; then
    printf "%s\n" "$(date +%F)"
    return 0
  fi
  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  __usageEnvironment "$usage" gitEnsureSafeDirectory "$home" || return $?
  __usageEnvironment "$usage" git rev-parse --short HEAD || return $?
}
___hookApplicationChecksum() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationChecksum "$@"
