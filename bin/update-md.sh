#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
me="$(basename "${BASH_SOURCE[0]}")"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

addNoteTo() {
    statusMessage consoleInfo "Adding note to $1"
    cp "$1" bin/build
    printf "\n%s" "(this file is a copy - please modify the original)" >>"bin/build/$1"
    git add "bin/build/$1"
}

addNoteTo README.md
addNoteTo LICENSE.md

buildMarker=bin/build/build.json

statusMessage consoleInfo "Generating build.json"
printf "%s" "{}" | jq --arg version "$(runHook version-current)" \
    --arg tag "$(runHook application-tag)" \
    --arg checksum "$(runHook application-checksum)" \
    '. + {version: $version, tag: $tag, checksum: $checksum}' >"$buildMarker"
git add "$buildMarker"

env | sort >.update-md.env
if ! git diff-index --quiet HEAD; then
    statusMessage consoleInfo "Committing build.json"
    if [ ! -f ".$me" ]; then
        touch ".$me"
        git commit -m "Updating build.json" "$buildMarker"
        [ ! -f "$me" ] || rm ".$me"
    else
        statusMessage consoleWarning "Skipping update during commit hook"
    fi
fi
clearLine
