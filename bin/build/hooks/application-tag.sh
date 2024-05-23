#!/usr/bin/env bash
#
# Fetch the version tag for the application
#
# Depends: git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if ! source "$(dirname "${BASH_SOURCE[0]}")/../tools.sh"; then
  printf "tools.sh failed" 1>&2
  exit 1
fi

# fn: {base}
#
# Get the "tag" (or current display version) for an application
#
# The default hook uses most recent tag associated in git or `v0.0.1` if no tags exist.
#
hookApplicationTag() {
  local argument
  # IDENTICAL this_usage 4
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return 0
        ;;
      *)
        __failArgument "Unknown argument: $argument" || return $?
        ;;
    esac
    shift || :
  done

  __usageEnvironment "$usage" gitEnsureSafeDirectory "$(pwd)" || return $?
  if ! git for-each-ref --format '%(refname:short)' refs/tags/ | grep -E '^v[0-9\.]+$' | versionSort -r | head -n 1 2>/dev/null; then
    printf %s "v0.0.1"
  fi
}
_hookApplicationTag() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

hookApplicationTag "$@"
