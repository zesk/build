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
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

whichApt curl curl

curl -o - -s "https://api.github.com/repos/$1/releases/latest" | jq -r .name
