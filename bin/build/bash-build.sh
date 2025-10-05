#!/usr/bin/env bash
#
# Script to set up a local bash environment with our tools already loaded
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__bashRunCommandsDefault() {
  local tools="$1" && shift 1
  printf "%s\n" "#!/usr/bin/env bash" "# Automatically generated" "# shellcheck source=/dev/null" "source \"$tools\"" "bashPrompt" "$@"
}

__bashRunCommandsAppendIfNeeded() {
  local tools="$1" rcFile="$2" && shift 2
  if [ -f "$rcFile" ] && grep -q bashPrompt "$rcFile"; then
    return 0
  fi
  printf "%s\n" "" "# shellcheck source=/dev/null" "source \"$tools\"" "bashPrompt" "$@" >>"$rcFile"
}

__bashBuild() {
  local handler="returnMessage"
  local tools="${BASH_SOURCE[0]%/*}/tools.sh"

  # shellcheck source=/dev/null
  if ! source "$tools"; then
    printf -- "%s\n" "Unable to source $tools"
    exec bash "$@"
  fi
  local home
  if home=$(userHome); then
    local extraCommands=() rcFile="$home/.bashrc"
    if [ "${1-}" = "--rc-extras" ]; then
      shift
      while [ $# -gt 0 ]; do
        if [ "$1" == "--" ]; then
          shift && break
        fi
        extraCommands+=("$1") && shift
      done
    fi
    tools="$(realPath "$tools")" || return $?
    if [ ! -f "$rcFile" ]; then
      __bashRunCommandsDefault "$tools" "${extraCommands[@]+"${extraCommands[@]}"}" >"$rcFile" || returnEnvironment "Failed to create $rcFile" || return $?
    else
      __bashRunCommandsAppendIfNeeded "$tools" "$rcFile" "${extraCommands[@]+"${extraCommands[@]}"}" || returnEnvironment "Failed to update $rcFile" || return $?
    fi
  fi
  local start
  start=$(timingStart)
  statusMessage decorate success "Setting up operating system with required base packages ..."
  returnCatch "$handler" packageUpdate || return $?
  returnCatch "$handler" packageInstall || return $?
  statusMessage --last timingReport "$start" "System set up in"
  exec bash "$@"
}

__bashBuild "$@"
