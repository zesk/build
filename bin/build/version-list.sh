#!/usr/bin/env bash
#
# version-list.sh - List versions
#
# Depends: git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL bashHeader2 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

gitVersionList "$@"
