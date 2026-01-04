#!/usr/bin/env bash
#
# Run during bin/build/release-new.sh when a new version is created
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# shellcheck source=/dev/null
set -eou pipefail

if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then
  # fn: {base}
  #
  # Run whenever `releaseNew` is run and a version was just created.
  #
  # Opens the release notes in the current editor.
  #
  # Environment: BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook
  __buildVersionCreated() {
    local handler="_${FUNCNAME[0]}"
    local home

    home=$(catchReturn "$handler" buildHome) || return $?
    catchEnvironment "$handler" gitBranchify || return $?

    # deprecated.txt add version comment
    catchEnvironment "$handler" deprecatedFilePrependVersion "$home/bin/build/deprecated.txt" "$1" || return $?

    hookRunOptional --next "${BASH_SOURCE[0]}" "version-created" "$@"
  }
  ___buildVersionCreated() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildVersionCreated "$@"
fi
