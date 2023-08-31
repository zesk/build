#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh before tagging
#
# Add any files to your repository here and commit them automatically if they need to be
#
set -eo pipefail

errEnv=1
me=$(basename "${BASH_SOURCE[0]}")
if ! cd "$(dirname "${BASH_SOURCE[0]}")/../.."; then
    echo "$me: Can not cd" && exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleSuccess "$me is the sample script, please update for production sites."
