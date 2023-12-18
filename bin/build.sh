#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2023 Market Acumen, Inc.
#

set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

./bin/update-md.sh --skip-commit
./bin/build-docs.sh
if gitRepositoryChanged; then
    git commit -m "Documentation version $(runHook version-current)" -a
    git push
fi
