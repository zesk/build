#!/usr/bin/env bash
#
# Fetch the version tag for the application
#
# Depends: git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

git describe --tags --abbrev=0
