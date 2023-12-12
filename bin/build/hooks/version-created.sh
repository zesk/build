#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version is created
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

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
  if ! test "$BUILD_VERSION_NO_OPEN"; then
    contextOpen "$releaseNotes"
  fi
}

hookVersionCreated "$@"
