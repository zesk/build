#!/usr/bin/env bash
#
# github-version-live.sh
#
# Depends: apt.sh
#
# Get the live version from the GitHub API
#
# Usage:
#
#     github-version-live.sh owner/repo
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eo pipefail

errEnv=1

me=$(basename "$0")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

bin/build/install/apt.sh

curl -o - -s "https://api.github.com/repos/$1/releases/latest" | jq -r .name
