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

cd docs/release
for f in *.md; do
    f=${f%.md}
    echo "$f"
done | versionSort -r | head -1
