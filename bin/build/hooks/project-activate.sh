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
# Use the time now to overwrite environment variables which MUST change here or MUST be active here to work, etc.
# This is NOT like other hooks in that it is run as `hookSource`
# See: bashPromptModule_binBuild
# Argument: otherHomeDirectory - The old home directory of the project
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
  name=$(returnCatch "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
  home=$(returnCatch "$handler" buildHome) || return $?
  [ -n "$name" ] || name="${home##*/}"

  statusMessage --last printf -- "%s %s %s %s\n" "$symbol" "$(decorate subtle "$otherName")" "➜" "$(decorate info "$name")"

  local item items=() candidates=("bin/developer.sh" "bin/developer/")

  for item in "${candidates[@]}"; do [ ! -e "$home/$item" ] || items+=("$home/$item"); done

  [ ${#items[@]} -eq 0 ] || approveBashSource --report --delete --verbose --prefix "Activate" "${items[@]}" || return $?
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
fi
