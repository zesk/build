#!/usr/bin/env bash
#
# Fetch the version tag for the application
#
# Copyright &copy; 2026 Market Acumen, Inc.
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
  local handler="_${FUNCNAME[0]}"
  local home

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  home=$(catchReturn "$handler" buildHome) || return $?

  if ! home="$(gitFindHome "$home" 2>/dev/null)" || [ -z "$home" ]; then
    printf "%s\n" "$(date +%F)"
    return 0
  fi
  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  catchReturn "$handler" gitEnsureSafeDirectory "$home" || return $?
  if ! git for-each-ref --format '%(refname:short)' refs/tags/ | grep -E '^v[0-9\.]+$' | versionSort -r | head -n 1 2>/dev/null; then
    printf %s "v0.0.1"
  fi
}
___hookApplicationTag() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationTag "$@"
