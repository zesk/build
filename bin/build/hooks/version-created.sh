#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version is created
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if ! source "$(dirname "${BASH_SOURCE[0]}")/../tools.sh"; then
  printf "tools.sh failed" 1>&2
  exit 1
fi

export BUILD_VERSION_NO_OPEN
BUILD_VERSION_NO_OPEN=${BUILD_VERSION_NO_OPEN-}

# fn: {base}
#
# Run whenever `new-version.sh` is run and a version was just created.
#
# Opens the release notes in the current editor.
#
# Environment: BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook
#
hookVersionCreated() {
  currentVersion=$1
  shift
  releaseNotes=$1
  shift

  printf "%s %s %s %s\n" "$(consoleSuccess "Created")" "$(consoleCode "$currentVersion")" "$(consoleSuccess "release notes are")" "$(consoleValue "$currentVersion")"
  if buildEnvironmentLoad BUILD_VERSION_NO_OPEN && ! test "$BUILD_VERSION_NO_OPEN"; then
    printf "%s %s %s %s\n" "$(consoleSuccess "Opening")" "$(consoleCode "$currentVersion")" "$(consoleSuccess "release notes at")" "$(consoleValue "$releaseNotes")"
    contextOpen "$releaseNotes"
  fi
}

hookVersionCreated "$@"
