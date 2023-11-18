#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version was already created
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

currentVersion=$1
shift
releaseNotes=$1
shift

consoleSuccess "Current version is $currentVersion, release notes are $releaseNotes"
