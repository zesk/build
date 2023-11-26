#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh after release is completed
#
# Do any post-release steps you want (update your website etc.)
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
#
hookGithubReleaseAfter() {
    consoleSuccess "$(basename "${BASH_SOURCE[0]}") is the sample script, please update for production sites."
}

hookGithubReleaseAfter "$@"
