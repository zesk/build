#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

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

__tools .. __updateMarkdown "$@"
