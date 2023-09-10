#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

currentBranch=$(git branch --show-current)
if [ "$currentBranch" = "main" ] || [ "$currentBranch" = "develop" ]; then
    consoleWarning "Running on $currentBranch - unable to make change"
    exit 1
fi

currentVersion="$(runHook version-current)"
addNoteTo() {
    cp "$1" bin/build
    {
        echo
        echo "(this file is a copy - please modify the original)"
    } >>"bin/build/$1"
    git add "bin/build/$1"
}
addNoteTo README.md
addNoteTo LICENSE.md
git commit -m "updated license and readme for $currentVersion" -a || :
git push
