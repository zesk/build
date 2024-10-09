#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"

#
# The `git-pre-commit` hook self-installs as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# It will:
# 1. Updates the help file templates
# 2. Checks all shell files for errors
# fn: {base}
__hookProjectSelected() {
  local usage="_${FUNCNAME[0]}" home

  export APPLICATION_NAME
  __usageEnvironment "$usage" buildEnvironmentLoad APPLICATION_NAME || return $?
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  [ -n "$APPLICATION_NAME" ] || APPLICATION_NAME="${home##*/}"
  consoleInfo "🌎 $APPLICATION_NAME"
}
___hookProjectSelected() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookProjectSelected "$@"
