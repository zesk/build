#!/usr/bin/env bash
#
# Fetch the version tag for the application
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
#
# Get the "tag" (or current display version) for an application
#
# The default hook uses most recent tag associated in git or `v0.0.1` if no tags exist.
#
__hookApplicationTag() {
  local argument
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
  home=$(gitFindHome 2>/dev/null) || printf "%s" "v0.0.0" && return 0
  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  __usageEnvironment "$usage" gitEnsureSafeDirectory "$home" || return $?
  if ! git for-each-ref --format '%(refname:short)' refs/tags/ | grep -E '^v[0-9\.]+$' | versionSort -r | head -n 1 2>/dev/null; then
    printf %s "v0.0.1"
  fi
}
___hookApplicationTag() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationTag "$@"
