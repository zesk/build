#!/usr/bin/env bash
#
# Fetch an ID which represents the current application build/code state which is unique
#
# Depends: git
#
# Copyright &copy; 2024 Market Acumen, Inc.
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
  local here argument
  local usage

  usage="_${FUNCNAME[0]}"

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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

  here="$(pwd -P 2>/dev/null)" || __failEnvironment "$usage" "pwd failed" || return $?
  __usageEnvironment "$usage" gitEnsureSafeDirectory "$here" || return $?
  __usageEnvironment "$usage" git rev-parse --short HEAD || return $?
}
___hookApplicationChecksum() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationChecksum "$@"
