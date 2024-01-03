#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

./bin/update-md.sh --skip-commit

# This takes a long time, keep as pre-commit
# ./bin/build-docs.sh

if gitRepositoryChanged; then
    git commit -m "Build version $(runHook version-current)" -a
    git push origin
fi
