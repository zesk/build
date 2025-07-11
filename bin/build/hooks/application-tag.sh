#!/usr/bin/env bash
#
# Fetch the version tag for the application
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
#
# Get the "tag" (or current display version) for an application
#
# The default hook uses most recent tag associated in git or `v0.0.1` if no tags exist.
#
__hookApplicationTag() {
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
  if ! git for-each-ref --format '%(refname:short)' refs/tags/ | grep -E '^v[0-9\.]+$' | versionSort -r | head -n 1 2>/dev/null; then
    printf %s "v0.0.1"
  fi
}
___hookApplicationTag() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationTag "$@"
