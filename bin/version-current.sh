#!/usr/bin/env bash
set -eo pipefail
errEnv=1

me=$(basename "$0")
relTop=".."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

#shellcheck source=/dev/null
. "./bin/build/colors.sh"

cd docs/release
for f in *.md; do
    f=${f%.md}
    echo "$f"
done | versionSort -r | head -1
