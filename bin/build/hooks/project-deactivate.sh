#!/usr/bin/env bash
#
# Hook: project-deactivate
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-source-header 2
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# This hook is run when leaving one project and switching to another.
# When run – the current context is the *old* project and new new project home is passed as the first argument
# to the function set in the environment variable `BUILD_PROJECT_DEACTIVATE`
#
# If this function is NOT a function, then this hook does nothing.
#
# If it is a function, then the function is run with the first argument with the new project home.
#
# Your deactivation function should:
#
# - Modify the `PATH` to remove any paths which are specific to your project
# - Unset any global variables which may overlap or affect another project
# - Unset any functions which have no usage outside of your project scope
# - Unalias any shell aliases which are specific to your project
#
# As well it can output anything desired to the console. Before this function exits the value of `BUILD_PROJECT_DEACTIVATE` is unset.
#
# > The legacy method of doing this was creating a file called `bin/developer-undo.sh` - if your project contains this file then a warning is output.
# Environment: BUILD_PROJECT_DEACTIVATE
# Environment: BUILD_HOME
__hookProjectDeactivate() {
  local newHome
  local handler="_${FUNCNAME[0]}"

  newHome=$(usageArgumentDirectory "$handler" "newProjectHome" "${1-}") || return $?

  # Warning about deprecated scripts
  local home item candidates=("bin/developer-undo.sh")
  home=$(catchReturn "$handler" buildHome) || return $?
  for item in "${candidates[@]}"; do [ ! -e "$home/$item" ] || decorate warning "$item exists and is deprecated"; done

  local func
  func=$(catchReturn "$handler" buildEnvironmentGet BUILD_PROJECT_DEACTIVATE) || return $?
  if isFunction "$func"; then
    statusMessage decorate warning "Deactivating old project with $(decorate code "$func") $(decorate file "$newHome")"
    catchReturn "$handler" "$func" "$newHome" || return $?

    unset BUILD_PROJECT_DEACTIVATE
  fi
}
___hookProjectDeactivate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

if [ "$(basename "${0##-}")" != "$(basename "${BASH_SOURCE[0]}")" ]; then
  # sourced
  __hookProjectDeactivate "$@" || printf "%s\n" "Project context deactivation failed" 1>&2 || :
else
  # run
  decorate warning "$(basename "${BASH_SOURCE[0]}") does nothing when hookRun - use hookSource" 1>&2
fi
