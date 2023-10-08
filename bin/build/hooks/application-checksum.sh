#!/usr/bin/env bash
#
# Fetch a checksum which represents the current application build/code state which is unique
#
# Depends: git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

git rev-parse --short HEAD
