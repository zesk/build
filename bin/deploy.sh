#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL zesk-build-bin-header 10
_fail() {
  local errorEnvironment=1
  printf "%s\n" "$*" 1>&2
  return "$errorEnvironment"
}
_init() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." || _fail "cd .. failed" || return $?
  # shellcheck source=/dev/null
  . ./bin/build/tools.sh || return $?
}

#
# Deploy Zesk Build
#
buildDeploy() {
  local fail start appId notes

  set -eou pipefail
  _init || _fail "_init failed" || return $?

  fail="_${FUNCNAME[0]}"
  if ! start=$(beginTiming); then
    "$fail" $errorEnvironment "beginTiming failed" || return $?
  fi
  if ! gitTagVersion; then
    "$fail" $errorEnvironment "Unable to tag version" || return $?
  fi
  if ! currentVersion="$(runHook version-current)"; then
    "$fail" $errorEnvironment "runHook version-current failed" || return $?
  fi
  if ! appId=$(runHook application-id); then
    "$fail" $errorEnvironment "runHook application-id failed" || return $?
  fi
  if [ -z "$currentVersion" ]; then
    "$fail" $errorEnvironment "No current version" || return $?
  fi
  if [ -z "$appId" ]; then
    "$fail" $errorEnvironment "No application ID (blank?)" || return $?
  fi
  if ! notes=$(releaseNotes) || [ ! -f "$notes" ]; then
    "$fail" $errorEnvironment "Missing release notes at $notes" || return $?
  fi
  bigText "$currentVersion" | wrapLines "$(consoleMagenta)" "$(consoleReset)" || :
  consoleInfo "Deploying a new release ... " || :

  if ! githubRelease "$notes" "$currentVersion" "$appId"; then
    consoleWarning "Deleting tagged version ... " || :
    gitTagDelete "$currentVersion" || consoleError "gitTagDelete $currentVersion ALSO failed but continuing ..." || :
    "$fail" $errorEnvironment "githubRelease FAILED" || return $?
  fi
  reportTiming "$start" Release completed in || :

}
_buildDeploy() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildDeploy
