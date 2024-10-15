#!/usr/bin/env bash
#
# Hook: project-selected
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"

#
# The `project-selected` hook runs when this project is activated in the console (and another project was previously active)
# Use the time now to overwrite environment variables which MUST change here or MUST be active here to work, etc.
# See: bashPromptModule_binBuild
# Argument: oldHomeDirectory - The old home directory of the project
__hookProjectSelected() {
  local usage="_${FUNCNAME[0]}" home oldName="" oldHome tools="bin/build/tools.sh"
  local symbol="🍎"

  oldHome=$(usageArgumentString "$usage" "oldHomeDirectory" "${1-}") || return $?
  oldHome=${oldHome%/} # Strip trailing slash
  if [ -d "$oldHome" ] && [ -x "$oldHome/$tools" ]; then
    # Fetch old application name
    oldName=$("$oldHome/$tools" buildEnvironmentGet APPLICATION_NAME)
  fi
  [ -n "$oldName" ] || oldName="${oldHome##*/}"
  name=$(__usageEnvironment "$usage" buildEnvironmentGet APPLICATION_NAME) || return $?
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  [ -n "$name" ] || name="${home##*/}"
  printf -- "%s %s %s %s\n" "$symbol" "$(consoleSubtle "$oldName")" "➜" "$(consoleInfo "$name")"
}
___hookProjectSelected() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookProjectSelected "$@"
