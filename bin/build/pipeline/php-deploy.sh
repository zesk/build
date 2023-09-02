#!/usr/bin/env bash
#
# Deploy a PHP Application
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

errEnv=1
set -eo pipefail
# set -x # Debugging

relTop="../../.."
me=$(basename "${BASH_SOURCE[0]}")
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

requireEnvironments=(DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS)

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

# shellcheck source=/dev/null
set -a && source .build.env

usageEnvironment "${requireEnvironments[@]}"

bin/build/pipeline/deploy-to.sh "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"
runHook deploy-confirm
bin/build/pipeline/deploy-to.sh --cleanup "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"
