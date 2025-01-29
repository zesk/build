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
__hookApplicationID() {
  local usage="_${FUNCNAME[0]}"
  local home

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  home=$(__catchEnvironment "$usage" buildHome) || return $?
  if ! home="$(gitFindHome "$home" 2>/dev/null)" || [ -z "$home" ]; then
    printf "%s\n" "$(date +%F)"
    return 0
  fi
  __catchEnvironment "$usage" muzzle pushd "$home" || return $?
  __catchEnvironment "$usage" gitEnsureSafeDirectory "$home" || return $?
  __catchEnvironment "$usage" git rev-parse --short HEAD || return $?
}
___hookApplicationID() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationID "$@"
