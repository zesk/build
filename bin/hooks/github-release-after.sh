#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh after release is completed
#
# Do any post-release steps you want (update your website etc.)
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # fn: {base}
  #
  # Optional hook run during `github-release.sh` after release is completed. Do any post-release work here.
  #
  __hookGithubReleaseAfter() {
    ! buildDebugEnabled || decorate success "$(basename "${BASH_SOURCE[0]}") is the sample script, please update for production sites."
    : "$@"
  }

  __hookGithubReleaseAfter "$@"
fi
