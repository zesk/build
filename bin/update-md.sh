#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

_usageUpdateMarkdown() {
  usageDocument "bin/$(dirname "${BASH_SOURCE[0]}")" updateMarkdown "$@"
}

addNoteTo() {
  statusMessage consoleInfo "Adding note to $1"
  cp "$1" bin/build
  printf "\n%s" "(this file is a copy - please modify the original)" >>"bin/build/$1"
  git add "bin/build/$1"
}

#
# Usage: {fn} [ --skip-commit ]
# Argument: --skip-commit - Skip the commit if the files change
#
updateMarkdown() {
  flagSkipCommit=
  while [ $# -gt 0 ]; do
    case $1 in
      --skip-commit)
        flagSkipCommit=1
        statusMessage consoleWarning "Skipping commit ..."
        ;;
      *)
        _usageUpdateMarkdown $errorArgument "Bad argument $1"
        ;;
    esac
    shift
  done
  addNoteTo README.md
  addNoteTo LICENSE.md

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
        git commit -m "Updating build.json" "$buildMarker" || :
        git push origin
      fi
    else
      statusMessage consoleWarning "Skipping update during commit hook"
    fi
  fi
  clearLine
}

updateMarkdown "$@"
