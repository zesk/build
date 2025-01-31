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
# Usage: {fn}
#
# Hook to return the current version
#
# Defaults to the last version numerically found in `docs/release` directory.
#
__hookVersionCurrent() {
  export BUILD_RELEASE_NOTES
  local usage

  usage="_${FUNCNAME[0]}"

  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_RELEASE_NOTES || return $?
  __catchEnvironment "$usage" cd "${BUILD_RELEASE_NOTES}" || return $?
  for f in *.md; do
    f=${f%.md}
    echo "$f"
  done | versionSort -r | head -1
}
___hookVersionCurrent() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookVersionCurrent
