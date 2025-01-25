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
# The `project-activate` hook runs when this project is activated in the console (and another project was previously active)
# Use the time now to overwrite environment variables which MUST change here or MUST be active here to work, etc.
# This is NOT like other hooks in that it is run as `hookSource`
# See: bashPromptModule_binBuild
# Argument: otherHomeDirectory - The old home directory of the project
__hookProjectActivate() {
  local usage="_${FUNCNAME[0]}" home otherName="" otherHome tools="bin/build/tools.sh"
  local symbol="🍎"

  otherHome=$(usageArgumentString "$usage" "otherHomeDirectory" "${1-}") || return $?
  otherHome=${otherHome%/} # Strip trailing slash
  if [ -d "$otherHome" ] && [ -x "$otherHome/$tools" ]; then
    # Fetch old application name
    otherName=$("$otherHome/$tools" buildEnvironmentGet APPLICATION_NAME)
  fi
  [ -n "$otherName" ] || otherName="${otherHome##*/}"
  name=$(__catchEnvironment "$usage" buildEnvironmentGet APPLICATION_NAME) || return $?
  home=$(__catchEnvironment "$usage" buildHome) || return $?
  [ -n "$name" ] || name="${home##*/}"
  statusMessage --last printf -- "%s %s %s %s\n" "$symbol" "$(decorate subtle "$otherName")" "➜" "$(decorate info "$name")"
}
___hookProjectActivate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookProjectActivateContext() {
  local usage="_${FUNCNAME[0]}" home

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  bashSourceInteractive --vebose --prefix "Activate" "$home/bin/developer.sh" "$home/bin/developer/" || return $?
}
___hookProjectActivateContext() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# shellcheck source=/dev/null
if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  # Only require when running as a shell command
  __hookProjectActivate "$@"
else
  __hookProjectActivate
  __hookProjectActivateContext
fi
