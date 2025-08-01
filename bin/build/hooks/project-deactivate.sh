#!/usr/bin/env bash
#
# Hook: project-deactivate
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-source-header 2
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# Run the deactivate function
__hookProjectDeactivateContext() {
  local newHome
  local handler="_${FUNCNAME[0]}"

  newHome=$(usageArgumentDirectory "$handler" "newProjectHome" "${1-}") || return $?

  # Warning about deprecated scripts
  local home item candidates=("bin/developer-undo.sh" "bin/developer/")
  home=$(__catch "$handler" buildHome) || return $?
  for item in "${candidates[@]}"; do [ ! -e "$home/$item" ] || decorate warning "$item exists and is deprecated"; done

  local func

  func=$(__catch "$handler" buildEnvironmentGet BUILD_PROJECT_DEACTIVATE) || return $?

  if isFunction "$func"; then
    statusMessage decorate warning "Deactivating old project with $(decorate code "$func") $(decorate file "$newHome")"
    __catch "$handler" "$func" "$newHome" || return $?

    unset BUILD_PROJECT_DEACTIVATE
  fi
}
___hookProjectDeactivateContext() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

if [ "$(basename "${0##-}")" != "$(basename "${BASH_SOURCE[0]}")" ]; then
  # sourced
  __hookProjectDeactivateContext "$@" || printf "%s\n" "Project context deactivation failed" 1>&2 || :
else
  # run
  decorate warning "$(basename "${BASH_SOURCE[0]}") does nothing when hookRun - use hookSource" 1>&2
fi
