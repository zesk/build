#!/usr/bin/env bash
#
# Sample current version script, uses release files directory listing and versionSort.
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

#shellcheck source=/dev/null
. "./bin/build/tools.sh"

# fn: {base}
#
# Hook to return the current version
#
# Defaults to the last version numerically found in `docs/release` directory.
#
# Environment: BUILD_VERSION_CREATED_EDITOR - Define editor to use to edit release notes
# Environment: EDITOR - Default if `BUILD_VERSION_CREATED_EDITOR` is not defined
#
hookVersionCurrent() {
    cd docs/release
    for f in *.md; do
        f=${f%.md}
        echo "$f"
    done | versionSort -r | head -1
}

hookVersionCurrent
