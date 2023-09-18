#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."
# shellcheck source=/dev/null
. ./bin/build/tools.sh

bin/build/cannon.sh release-check-version.sh git-tag-version.sh ! -path '*/deprecated.sh' ! -path '*/docs/release/*.md'
# v0.3.12
bin/build/cannon.sh 'failed "' 'buildFailed "' -name '*.sh' ! -path '*/deprecated.sh' ! -path '*/docs/release/*.md'
