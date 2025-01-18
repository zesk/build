#!/usr/bin/env bash
#
# Hook: project-activate
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"

#
# The `project-deactivate` hook runs when this project is activated in the console (and another project was previously active)
# Use the time now to overwrite environment variables which MUST change here or MUST be active here to work, etc.
# See: bashPromptModule_binBuild
# Argument: otherHomeDirectory - The old home directory of the project
__hookProjectDeactivate() {
  local usage="_${FUNCNAME[0]}" home otherName="" otherHome tools="bin/build/tools.sh"
  local symbol="🍎"

  otherHome=$(usageArgumentString "$usage" "otherHomeDirectory" "${1-}") || return $?
  otherHome=${otherHome%/} # Strip trailing slash
  if [ -d "$otherHome" ] && [ -x "$otherHome/$tools" ]; then
    # Fetch old application name
    otherName=$("$otherHome/$tools" buildEnvironmentGet APPLICATION_NAME)
  fi
  [ -n "$otherName" ] || otherName="${otherHome##*/}"
  name=$(__usageEnvironment "$usage" buildEnvironmentGet APPLICATION_NAME) || return $?
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  [ -n "$name" ] || name="${home##*/}"
  statusMessage printf -- "%s %s %s %s\n" "$symbol" "$(decorate subtle "$name")" "➜" "$(decorate success "$otherName")"
}
___hookProjectDeactivate() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookProjectDeactivateContext() {
  local usage="_${FUNCNAME[0]}" home

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  bashSourceInteractive --vebose --prefix "Deactivate" "$home/bin/developer-undo.sh" "$home/bin/developer-undo/" || return $?
}
___hookProjectDeactivateContext() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# shellcheck source=/dev/null
if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  # Only require when running as a shell command
  __hookProjectDeactivate "$@"
else
  __hookProjectDeactivate
  __hookProjectDeactivateContext
fi
