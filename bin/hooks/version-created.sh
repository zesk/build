#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version is created
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# shellcheck source=/dev/null
set -eou pipefail

source "${BASH_SOURCE[0]%/*}/../build/tools.sh"

# fn: {base}
#
# Run whenever `new-version.sh` is run and a version was just created.
#
# Opens the release notes in the current editor.
#
# Environment: BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook
#
__buildVersionCreated() {
  local handler="returnMessage"
  local home

  home=$(__catch "$handler" buildHome) || return $?
  __catchEnvironment "$handler" gitBranchify || return $?

  # deprecated.txt add version comment
  __catchEnvironment "$handler" deprecatedFilePrependVersion "$home/bin/build/deprecated.txt" "$1" || return $?

  hookRunOptional --next "${BASH_SOURCE[0]}" "version-created" "$@"
}

__buildVersionCreated "$@"
