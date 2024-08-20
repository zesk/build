#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __source 17
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__source() {
  local me="${BASH_SOURCE[0]}" e=253
  local here="${me%/*}" a=()
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  while [ $# -gt 0 ]; do a+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 7
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

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
