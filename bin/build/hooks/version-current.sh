#!/usr/bin/env bash
#
# Sample current version script, uses release files directory listing and versionSort.
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if ! source "$(dirname "${BASH_SOURCE[0]}")/../tools.sh"; then
  printf "tools.sh failed" 1>&2
  exit 1
fi

# shellcheck source=/dev/null
. ./bin/build/env/BUILD_RELEASE_NOTES.sh

# fn: {base}
#
# Hook to return the current version
#
# Defaults to the last version numerically found in `docs/release` directory.
#
# Environment: BUILD_VERSION_CREATED_EDITOR - Define editor to use to edit release notes
# Environment: EDITOR - Default if `BUILD_VERSION_CREATED_EDITOR` is not defined
#
hookVersionCurrent() {
  export BUILD_RELEASE_NOTES
  # IDENTICAL this_usage 4
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_RELEASE_NOTES || return $?
  __usageEnvironment "$usage" cd "${BUILD_RELEASE_NOTES}" || return $?
  for f in *.md; do
    f=${f%.md}
    echo "$f"
  done | versionSort -r | head -1
}
_hookVersionCurrent() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookVersionCurrent
