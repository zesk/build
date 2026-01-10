#!/usr/bin/env bash
#
# Sample current version script, uses release files directory listing and versionSort.
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
#
# Hook to return the current version
#
# Defaults to the last version numerically found in `docs/release` directory.
# Requires: catchReturn catchEnvironment muzzle pushd cd printf versionSort popd usageDocument
__hookVersionCurrent() {
  export BUILD_RELEASE_NOTES
  local handler="_${FUNCNAME[0]}"
  local home

  home=$(catchReturn "$handler" buildHome) || return $?

  local notes
  notes=$(catchReturn "$handler" buildEnvironmentGet --application "$home" BUILD_RELEASE_NOTES) || return $?
  pathIsAbsolute "$notes" || notes="$home/$notes"
  catchEnvironment "$handler" muzzle pushd "$notes" || return $?
  find . -mindepth 1 -maxdepth 1 -name '*.md' | cut -c 3- | sed 's/.md//g' | versionSort -r | head -n 1 || :
  catchEnvironment "$handler" muzzle popd || return $?
}
___hookVersionCurrent() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookVersionCurrent
