#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh before tagging
#
# Add any files to your repository here and commit them automatically if they need to be
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

#
# Optional hook run during `github-release.sh` before tagging and pushing occurs
#
# fn: {base}
hookGithubReleaseBefore() {
    consoleSuccess "$(basename "${BASH_SOURCE[0]}") is the sample script, please update for production sites."
}

hookGithubReleaseBefore "$@"
