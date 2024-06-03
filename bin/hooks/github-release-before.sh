#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh before tagging
#
# Add any files to your repository here and commit them automatically if they need to be
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# fn: {base}
#
# We need to fetch an unshallow version for deployment to GitHub
#
hookGithubReleaseBefore() {
  consoleInfo "${FUNCNAME[0]} does nothing. Nice!"
}

hookGithubReleaseBefore "$@"
