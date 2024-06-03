#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL zesk-build-bin-header 11
set -eou pipefail

_fail() {
  local exit="$1"
  shift || :
  printf -- "ERROR: %s\n" "$*" 1>&2
  return "$exit"
}

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/build/tools.sh" || _fail $? "source tools.sh" || return $?

#
# Deploy Zesk Build
#
buildDeploy() {
  local start appId notes
  # IDENTICAL this_usage 4
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"

  start=$(beginTiming) || __failEnvironment "$usage" "beginTiming" || return $?
  __usageEnvironment "$usage" gitTagVersion || return $?
  currentVersion="$(runHook version-current)" || __failEnvironment "$usage" "runHook version-current" || return $?

  appId=$(runHook application-id) || __failEnvironment "$usage" "runHook application-id" || return $?

  [ -n "$currentVersion" ] || __failEnvironment "$usage" "Blank version-current" || return $?
  [ -n "$appId" ] || __failEnvironment "$usage" "No application ID (blank?)" || return $?

  notes=$(releaseNotes) || __failEnvironment "$usage" "releaseNotes" || return $?
  [ -f "$notes" ] || __failEnvironment "$usage" "$notes does not exist" || return $?

  bigText "$currentVersion" | wrapLines "$(consoleMagenta)" "$(consoleReset)" || :
  consoleInfo "Deploying a new release ... " || :

  if ! githubRelease "$notes" "$currentVersion" "$appId"; then
    consoleWarning "Deleting tagged version ... " || :
    gitTagDelete "$currentVersion" || consoleError "gitTagDelete $currentVersion ALSO failed but continuing ..." || :
    __failEnvironment "$usage" "githubRelease" || return $?
  fi
  reportTiming "$start" "Release completed in" || :
}
_buildDeploy() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildDeploy "$@"
