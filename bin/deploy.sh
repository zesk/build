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
  printf "%s\n" "$*" 1>&2
  exit 1
}

set -eou pipefail || _fail "set -eou pipefail fail?"
cd "$(dirname "${BASH_SOURCE[0]}")/.." || _fail "cd $(dirname "${BASH_SOURCE[0]}")/.. failed"
# shellcheck source=/dev/null
. ./bin/build/tools.sh || _fail "tools.sh failed"
# zesk-build-bin-header

buildDeploy() {
  local start appId notes

  if ! start=$(beginTiming); then
    _buildDeploy $errorEnvironment "beginTiming failed" || return $?
  fi
  if ! gitTagVersion; then
    _buildDeploy $errorEnvironment "Unable to tag version" || return $?
  fi
  if ! currentVersion="$(runHook version-current)"; then
    _buildDeploy $errorEnvironment "runHook version-current failed" || return $?
  fi
  if ! appId=$(runHook application-id); then
    _buildDeploy $errorEnvironment "runHook application-id failed" || return $?
  fi
  if [ -z "$currentVersion" ]; then
    _buildDeploy $errorEnvironment "No current version" || return $?
  fi
  if [ -z "$appId" ]; then
    _buildDeploy $errorEnvironment "No application ID (blank?)" || return $?
  fi
  if ! notes=$(releaseNotes) || [ ! -f "$notes" ]; then
    _buildDeploy $errorEnvironment "Missing release notes at $notes" || return $?
  fi
  bigText "$currentVersion" | wrapLines "$(consoleMagenta)" "$(consoleReset)" || :
  consoleInfo "Deploying a new release ... " || :

  if ! githubRelease "$notes" "$currentVersion" "$appId"; then
    _buildDeploy $errorEnvironment "githubRelease FAILED" || return $?
  fi
  reportTiming "$start" Release completed in || :

}
_buildDeploy() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildDeploy
