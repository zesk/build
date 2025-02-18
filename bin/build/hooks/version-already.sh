#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version was already created
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
#
# Run whenever `new-version.sh` is run and a version already exists
#
# Opens the release notes in the current editor.
#
# Environment: BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook
#
__hookVersionAlready() {
  local currentVersion releaseNotes
  local usage="_return"

  export BUILD_VERSION_NO_OPEN

  currentVersion=$(usageArgumentString "$usage" version "${1-}") && shift || return $?
  releaseNotes=$(usageArgumentFile "$usage" releaseNotes "${1-}") && shift || return $?

  if buildEnvironmentLoad BUILD_VERSION_NO_OPEN && ! test "$BUILD_VERSION_NO_OPEN"; then
    printf "%s %s %s %s\n" "$(decorate success "Opening")" "$(decorate code "$currentVersion")" "$(decorate success "release notes at")" "$(decorate value "$releaseNotes")"
    contextOpen "$releaseNotes"
  else
    printf "%s %s %s %s\n" "$(decorate success "Already at")" "$(decorate code "$currentVersion")" "$(decorate success "release notes")" "$(decorate value "$releaseNotes")"
  fi
}

__hookVersionAlready "$@"
