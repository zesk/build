#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__binary.md

# IDENTICAL __tools 12
# Load zesk build and run command
__tools() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/tools.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
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

__tools .. __buildBuild "$@"
