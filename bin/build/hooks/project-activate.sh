#!/usr/bin/env bash
#
# Hook: project-activate
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-source-header 2
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"
#
# The `project-activate` hook runs when this project is activated in the console (and another project was previously active)
# Implementations MUST overwrite environment variables which MUST change here or MUST be active here to work, etc.
# This is NOT like other hooks in that it is run as `hookSource`
# See: bashPromptModule_binBuild
# Argument: otherHomeDirectory - The old home directory of the project
# BUILD_DEBUG: approve - Report on all approvals during project activation
# BUILD_DEBUG: approve-verbose - Display verbose approval messages
# See: hookSource
# See: approveBashSource
# See: buildDebugEnabled
__hookProjectActivate() {
  local handler="_${FUNCNAME[0]}" home otherName="" otherHome tools="bin/build/tools.sh"
  local symbol="🍎"

  otherHome=$(usageArgumentEmptyString "$handler" "otherHomeDirectory" "${1-}") || return $?
  otherHome=${otherHome%/} # Strip trailing slash
  if [ -d "$otherHome" ] && [ -x "$otherHome/$tools" ]; then
    # Fetch old application name
    otherName=$("$otherHome/$tools" buildEnvironmentGet APPLICATION_NAME)
  fi
  [ -n "$otherName" ] || otherName="${otherHome##*/}"
  name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
  home=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$name" ] || name="${home##*/}"

  statusMessage --last printf -- "%s %s %s %s (path: %s)\n" "$symbol" "$(decorate subtle "$otherName")" "➜" "$(decorate info "$name")" "$(decorate file --no-app "$home")"

  local item items=() candidates=("bin/developer.sh" "bin/developer/")

  for item in "${candidates[@]}"; do [ ! -e "$home/$item" ] || items+=("$home/$item"); done
  local rr=()
  ! buildDebugEnabled approve || rr+=("--report")
  ! buildDebugEnabled approve-verbose || rr+=("--verbose")
  [ ${#items[@]} -eq 0 ] || approveBashSource "${rr[@]+"${rr[@]}"}" --delete --prefix "Activate" "${items[@]}" || return $?
}
___hookProjectActivate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

if [ "$(basename "${0##-}")" != "$(basename "${BASH_SOURCE[0]}")" ]; then
  # sourced
  __hookProjectActivate "$@" || decorate warning "Project activation failed" || :
else
  # run
  decorate warning "$(basename "${BASH_SOURCE[0]}") does nothing when hookRun - use hookSource" 1>&2
  false
fi
