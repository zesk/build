#!/usr/bin/env bash
#
# Deploy a PHP Application
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# IDENTICAL me 1
me="$(basename "${BASH_SOURCE[0]}")"

_deployUsage() {
  usageDocument "bin/build/pipeline/$me" deployMain "$@"
  return $?
}

deploymentCleanup() {
  if [ $# -gt 0 ]; then
    consoleWarning "$@"
  else
    consoleSuccess "Deployment cleanup ..."
  fi
  bin/build/pipeline/deploy-to.sh --cleanup "$APPLICATION_CHECKSUM" "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"
}

# Deploy to a host
#
# Loads .build.env
#
# Environment: - DEPLOY_REMOTE_PATH - path on remote host for deployment data
# Environment: - APPLICATION_REMOTE_PATH - path on remote host for application
# Environment: - DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)
#
# "Not possible to deploy to different paths on different hosts"

deployMain() {
  local requireEnvironments=(APPLICATION_CHECKSUM DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS)

  if [ ! -f .build.env ]; then
    consoleWarning "No .build.env found" 1>&2
  else
    set -a
    # shellcheck source=/dev/null
    . .build.env
    set +a
  fi

  usageRequireEnvironment _deployUsage "${requireEnvironments[@]}"

  if ! bin/build/pipeline/deploy-to.sh --deploy "$APPLICATION_CHECKSUM" "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"; then
    deploymentCleanup "Deployment failed" || :
    return "$errorEnvironment"
  fi
  if hasHook deploy-confirm && ! runHook deploy-confirm; then
    deploymentCleanup "Deployment confirmation failed" || :
    return "$errorEnvironment"
  fi
  if ! deploymentCleanup; then
    consoleError "Deployment cleanup failed"
    return "$errorEnvironment"
  fi
  bigText Success | prefixLines "$(consoleSuccess)"
}

deployMain "$@"
