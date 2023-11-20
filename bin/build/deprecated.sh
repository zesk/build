#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."
# shellcheck source=/dev/null
. ./bin/build/tools.sh

# Clean up deprecated code automatically. This can be dangerous (uses `cannon`) so use it on
# a clean build checkout and examine changes manually each time.
#
# Does various checks for deprecated code and updates code.
# Usage: deprecatedCleanup
# Exit Code: 0 - All cleaned up
# Exit Code: 1 - If fails or validation fails
#
deprecatedCleanup() {
    local exitCode=0

    bin/build/cannon.sh release-check-version.sh git-tag-version.sh ! -path '*/deprecated.sh' ! -path '*/docs/release/*.md' || :
    # v0.3.12
    bin/build/cannon.sh 'failed "' 'buildFailed "' -name '*.sh' ! -path '*/deprecated.sh' ! -path '*/docs/release/*.md' || :

    if find . -type f ! -path '*/.*' -print0 | xargs -0 grep -l dockerPHPExtensions; then
        consoleError dockerPHPExtensions found
        exitCode=1
    fi
    return $exitCode
}

deprecatedCleanup
