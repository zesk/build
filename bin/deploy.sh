#!/usr/bin/env bash

set -eo pipefail
errEnv=1

me=$(basename "$0")
relTop=..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

./bin/build/pipeline/release-check-version.sh
currentVersion="$(runHook version-current)"
if [ -z "$currentVersion" ]; then
    exec 1>&2
    consoleError "No current version returned by version-current.sh"
    exit $errEnv
fi
releaseNotes="./docs/release/$currentVersion.md"
if [ ! -f "$releaseNotes" ]; then
    exec 1>&2
    consoleError "Missing release notes at $releaseNotes"
    exit $errEnv
fi
bigText "$currentVersion" | prefixLines "$(consoleMagenta)"
start=$(beginTiming)
consoleInfo -n "Deploying a new release "

APPLICATION_GIT_SHA=$(git rev-parse --short HEAD)
./bin/build/pipeline/github-release.sh "docs/release/$currentVersion.md" "$currentVersion" "$APPLICATION_GIT_SHA"

reportTiming "$start" Done
