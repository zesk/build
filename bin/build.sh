#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__binary.md

set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

buildBuild() {
  if ! ./bin/update-md.sh --skip-commit; then
    consoleError "Can not update the Markdown files" 1>&2
    return 1
  fi

  # This takes a long time, keep as pre-commit
  # ./bin/build-docs.sh

  if gitRepositoryChanged; then
    printf "%s\n" "CHANGES:"
    gitShowChanges | prefixLines "$(consoleCode)    "
    git commit -m "Build version $(runHook version-current)" -a || :
    git push origin
  fi
  consoleSuccess Built successfully.
}

buildBuild "$@"
bin/build/tools/pipeline.sh
