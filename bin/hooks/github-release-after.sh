#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh after release is completed
#
# Do any post-release steps you want (update your website etc.)
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# fn: {base}
#
# Optional hook run during `github-release.sh` after release is completed. Do any post-release work here.
#
hookGithubReleaseAfter() {
  consoleSuccess "$(basename "${BASH_SOURCE[0]}") is the sample script, please update for production sites."
}

hookGithubReleaseAfter "$@"
