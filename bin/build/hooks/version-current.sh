#!/usr/bin/env bash
#
# Sample current version script, uses release files directory listing and versionSort.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
# handler: {fn}
#
# Hook to return the current version
#
# Defaults to the last version numerically found in `docs/release` directory.
# Requires: __catch __catchEnvironment muzzle pushd cd printf versionSort popd usageDocument
__hookVersionCurrent() {
  export BUILD_RELEASE_NOTES
  local handler="_${FUNCNAME[0]}"
  local home

  home=$(__catch "$handler" buildHome) || return $?

  __catchEnvironment "$handler" muzzle pushd "$home" || return $?
  __catch "$handler" buildEnvironmentLoad BUILD_RELEASE_NOTES || return $?
  __catchEnvironment "$handler" cd "${BUILD_RELEASE_NOTES}" || return $?
  for f in *.md; do
    f=${f%.md}
    printf -- "%s\n" "$f"
  done | versionSort -r | head -1
  __catchEnvironment "$handler" muzzle popd || return $?
}
___hookVersionCurrent() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookVersionCurrent
