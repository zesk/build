#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 13
# Load zesk build and run command
__tools() {
  local relative="$1"
  set -eou pipefail
  shift
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/$relative/bin/build/tools.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
}

#
# Deploy Zesk Build
#
__buildDeploy() {
  local start appId notes
  local usage

  usage="${FUNCNAME[0]#_}"

  start=$(beginTiming) || __failEnvironment "$usage" "beginTiming" || return $?

  statusMessage consoleInfo "Fetching deep copy of repository ..." || :
  __usageEnvironment "$usage" git fetch --unshallow || return $?

  statusMessage consoleInfo "Collecting application version and ID ..." || :
  currentVersion="$(runHook version-current)" || __failEnvironment "$usage" "runHook version-current" || return $?
  appId=$(runHook application-id) || __failEnvironment "$usage" "runHook application-id" || return $?

  [ -n "$currentVersion" ] || __failEnvironment "$usage" "Blank version-current" || return $?
  [ -n "$appId" ] || __failEnvironment "$usage" "No application ID (blank?)" || return $?

  notes=$(releaseNotes) || __failEnvironment "$usage" "releaseNotes" || return $?
  [ -f "$notes" ] || __failEnvironment "$usage" "$notes does not exist" || return $?

  bigText "$currentVersion" | wrapLines "    $(consoleGreen "Zesk BUILD    🛠️️ ") $(consoleMagenta)" "$(consoleGreen " ⚒️ ")" || :
  consoleInfo "Deploying a new release ... " || :

  if ! githubRelease "$notes" "$currentVersion" "$appId"; then
    consoleWarning "Deleting tagged version ... " || :
    gitTagDelete "$currentVersion" || consoleError "gitTagDelete $currentVersion ALSO failed but continuing ..." || :
    __failEnvironment "$usage" "githubRelease" || return $?
  fi
  reportTiming "$start" "Release completed in" || :
}
_buildDeploy() {
  usageDocument "${BASH_SOURCE[0]}" "_${FUNCNAME[0]}" "$@"
}

__tools .. __buildDeploy "$@"
