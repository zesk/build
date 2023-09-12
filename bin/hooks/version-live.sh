#!/usr/bin/env bash
#
# Sample live version script, uses github API to fetch release version
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

bin/build/pipeline/github-version-live.sh zesk/build
