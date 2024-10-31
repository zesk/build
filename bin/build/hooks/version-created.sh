#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version is created
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
#
# Run whenever `new-version.sh` is run and a version was just created.
#
# Opens the release notes in the current editor.
#
# Environment: BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook
#
__hookVersionCreated() {
  currentVersion=$1
  shift
  releaseNotes=$1
  shift

  export BUILD_VERSION_NO_OPEN

  printf "%s %s %s %s\n" "$(decorate success "Created")" "$(decorate code "$currentVersion")" "$(decorate success "release notes are")" "$(decorate value "$currentVersion")"
  if buildEnvironmentLoad BUILD_VERSION_NO_OPEN && ! test "$BUILD_VERSION_NO_OPEN"; then
    printf "%s %s %s %s\n" "$(decorate success "Opening")" "$(decorate code "$currentVersion")" "$(decorate success "release notes at")" "$(decorate value "$releaseNotes")"
    contextOpen "$releaseNotes"
  fi
}

__hookVersionCreated "$@"
