#!/usr/bin/env bash
#
# Sample live version script, uses github API to fetch release version
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# fn: {base}
# Summary: Live version of the application
#
# Output the current live, published version of this application.
#
# If implemented, `new-release.sh` will create a release only when needed.
#
# See: github-version-live.sh
#
hookVersionLive() {
  bin/build/pipeline/github-version-live.sh zesk/build "$@"
}

hookVersionLive "$@"
