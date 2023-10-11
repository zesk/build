#!/usr/bin/env bash
#
# Deploy a PHP Application
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errorEnvironment=1
set -eo pipefail
# set -x # Debugging

me=$(basename "${BASH_SOURCE[0]}")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

requireEnvironments=(APPLICATION_CHECKSUM DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS)

usage() {
  local rs=$1

  shift
  exec 1>&2
  if [ -n "$*" ]; then
    consoleError "$@"
    echo
  fi
  consoleInfo "$me"
  echo
  consoleInfo "Deploy to a host"
  echo
  consoleInfo "Loads .build.env"
  echo
  consoleInfo "Requires environment: ${requireEnvironments[*]}"
  echo
  consoleInfo "DEPLOY_REMOTE_PATH - path on remote host for deployment data"
  consoleInfo "APPLICATION_REMOTE_PATH - path on remote host for application"
  consoleInfo "DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)"
  echo
  consoleInfo "Not possible to deploy to different paths on different hosts"
  exit "$rs"
}

if [ ! -f .build.env ]; then
  consoleWarning "No .build.env found" 1>&2
else
  # shellcheck source=/dev/null
  set -a && . .build.env
fi

usageEnvironment "${requireEnvironments[@]}"

deploymentCleanup() {
  if [ $# -gt 0 ]; then
    consoleWarning "$@"
  else
    consoleSuccess "Deployment cleanup ..."
  fi
  bin/build/pipeline/deploy-to.sh --cleanup "$APPLICATION_CHECKSUM" "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"
}

if ! bin/build/pipeline/deploy-to.sh --deploy "$APPLICATION_CHECKSUM" "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"; then
  deploymentCleanup "Deployment failed" || :
  exit "$errorEnvironment"
fi
if hasHook deploy-confirm && ! runHook deploy-confirm; then
  deploymentCleanup "Deployment confirmation failed" || :
  exit "$errorEnvironment"
fi
if ! deploymentCleanup; then
  consoleError "Deployment cleanup failed"
  exit "$errorEnvironment"
fi
bigText Success | prefixLines "$(consoleSuccess)"
