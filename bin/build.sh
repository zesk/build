#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__binary.md

# IDENTICAL zesk-build-bin-header 10
_fail() {
  printf "%s\n" "$*" 1>&2
  exit 1
}

set -eou pipefail || _fail "set -eou pipefail fail?"
cd "$(dirname "${BASH_SOURCE[0]}")/.." || _fail "cd $(dirname "${BASH_SOURCE[0]}")/.. failed"
# shellcheck source=/dev/null
. ./bin/build/tools.sh || _fail "tools.sh failed"
# zesk-build-bin-header

buildBuild() {
  if ! ./bin/update-md.sh --skip-commit; then
    consoleError "Can not update the Markdown files" 1>&2
    return 1
  fi

  # This takes a long time, keep as pre-commit
  # ./bin/build-docs.sh

  if gitRepositoryChanged; then
    printf "%s\n" "CHANGES:"
    gitShowChanges | wrapLines "$(consoleCode)    " "$(consoleReset)"
    git commit -m "Build version $(runHook version-current)" -a || :
    git push origin
  fi
  consoleSuccess Built successfully.
}

buildBuild "$@"
