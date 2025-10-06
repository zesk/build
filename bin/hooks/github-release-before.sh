#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh before tagging
#
# Add any files to your repository here and commit them automatically if they need to be
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # fn: {base}
  #
  # We need to fetch an unshallow version for deployment to GitHub
  #
  __hookGithubReleaseBefore() {
    ! buildDebugEnabled || decorate info "${FUNCNAME[0]} does nothing. Nice!"
    : "$@"
  }

  __hookGithubReleaseBefore "$@"
fi
