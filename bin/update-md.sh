#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

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

__addNoteTo() {
  statusMessage consoleInfo "Adding note to $1"
  cp "$1" bin/build
  printf "\n%s" "(this file is a copy - please modify the original)" >>"bin/build/$1"
  git add "bin/build/$1"
}

#
# Usage: {fn} [ --skip-commit ]
# Argument: --skip-commit - Skip the commit if the files change
#
__updateMarkdown() {
  local usage="${FUNCNAME[0]#_}"
  local flagSkipCommit buildMarker
  local argument

  flagSkipCommit=
  while [ $# -gt 0 ]; do
    argument="$1"
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --skip-commit)
        flagSkipCommit=1
        statusMessage consoleWarning "Skipping commit ..."
        ;;
      *)
        __failArgument "$usage" "unknown argument: $(consoleValue "$argument")" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleLabel "$argument")" || return $?
  done
  __addNoteTo README.md
  __addNoteTo LICENSE.md

  buildMarker=bin/build/build.json

  statusMessage consoleInfo "Generating build.json"
  printf "%s" "{}" | jq --arg version "$(runHook version-current)" \
    --arg id "$(runHook application-id)" \
    '. + {version: $version, id: $id}' >"$buildMarker"
  git add "$buildMarker" || :

  #
  # Disable this to see what environment shows up in commit hooks for GIT*=
  #
  # env | sort >.update-md.env
  #

  # Do this as long as we are not in the hook
  if ! test $flagSkipCommit; then
    if ! gitInsideHook; then
      if gitRepositoryChanged; then
        statusMessage consoleInfo "Committing build.json"
        __usageEnvironment "$usage" git commit -m "Updating build.json" "$buildMarker" || return $?
        __usageEnvironment "$usage" git push origin || return $?
      fi
    else
      statusMessage consoleWarning "Skipping update during commit hook" || :
    fi
  fi
  clearLine || :
}
_updateMarkdown() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"

}

__loader __updateMarkdown "$@"
