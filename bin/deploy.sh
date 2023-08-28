#!/usr/bin/env bash

set -eo pipefail
errEnv=1

me=$(basename "$0")
relTop=".."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

# shellcheck source=/dev/null
. "./bin/build/colors.sh"

./bin/build/release-check-version.sh
currentVersion="$(bin/version-current.sh)"
releaseNotes="./docs/release/$currentVersion.md"
if [ ! -f "$releaseNotes" ]; then
    exec 1>&2
    consoleError "Missing release notes at $releaseNotes"
    exit $errEnv
fi
bigText "$currentVersion" | prefixLines "$(consoleMagenta)"
start=$(beginTiming)
consoleInfo -n "Deploying a new release "
./bin/build/github-release.sh "docs/release/$currentVersion.md" "$currentVersion"
reportTiming "$start" Done
