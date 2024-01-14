#!/bin/bash
#
# new-release.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader2 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

newRelease "$@"
