#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__binary.md

# IDENTICAL zesk-build-bin-header 10
_fail() {
  local errorEnvironment=1
  printf "%s\n" "$*" 1>&2
  return "$errorEnvironment"
}
_init() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." || _fail "cd .. failed" || return $?
  # shellcheck source=/dev/null
  . ./bin/build/tools.sh || return $?
}

#
# Build Zesk Build
#
buildBuild() {
  set -eou  pipefail

  _init || _fail "_init failed" || return $?
  if ! ./bin/update-md.sh --skip-commit; then
    _fail "Can not update the Markdown files" || return $?
  fi

  # This takes a long time, keep as pre-commit
  # ./bin/build-docs.sh

  if gitRepositoryChanged; then
    printf "%s\n" "CHANGES:" || :
    gitShowChanges | wrapLines "$(consoleCode)    " "$(consoleReset)"
    git commit -m "Build version $(runHook version-current)" -a || :
    git push origin || :
  fi
  consoleSuccess Built successfully.
}

buildBuild "$@"
