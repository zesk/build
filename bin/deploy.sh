#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errEnv=1

set -eo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

usage() {
    local exitCode=$1

    shift
    exec 1>&2
    consoleError "$*"
    exit "$exitCode"
}

./bin/build/pipeline/git-tag-version.sh
currentVersion="$(runHook version-current)"
if [ -z "$currentVersion" ]; then
    usage $errEnv "No current version returned by version-current.sh"
fi
releaseNotes="./docs/release/$currentVersion.md"
if [ ! -f "$releaseNotes" ]; then
    usage $errEnv "Missing release notes at $releaseNotes"
fi
bigText "$currentVersion" | prefixLines "$(consoleMagenta)"
start=$(beginTiming)
consoleInfo -n "Deploying a new release "

APPLICATION_GIT_SHA=$(git rev-parse --short HEAD)
./bin/build/pipeline/github-release.sh "docs/release/$currentVersion.md" "$currentVersion" "$APPLICATION_GIT_SHA"

reportTiming "$start" Done
