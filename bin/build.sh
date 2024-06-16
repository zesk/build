#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__binary.md

# IDENTICAL __loader1 11
set -eou pipefail
# Load zesk build and run command
__loader() {
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/../bin/build/tools.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
}

#
# Build Zesk Build
#
__buildBuild() {
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
___buildBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__loader __buildBuild "$@"
