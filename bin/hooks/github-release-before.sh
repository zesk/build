#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh before tagging
#
# Add any files to your repository here and commit them automatically if they need to be
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 13
# Usage: __tools command ...
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

# fn: {base}
#
# We need to fetch an unshallow version for deployment to GitHub
#
__hookGithubReleaseBefore() {
  ! buildDebugEnabled || consoleInfo "${FUNCNAME[0]} does nothing. Nice!"
}

__tools ../.. __hookGithubReleaseBefore "$@"
