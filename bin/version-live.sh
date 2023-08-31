#!/usr/bin/env bash

set -eo pipefail
errEnv=1

me=$(basename "$0")
relTop=".."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

bin/build/pipeline/github-version-live.sh zesk/build
