#!/usr/bin/env bash
#
# Undeploy an application
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail
# set -x # Debugging

me=$(basename "${BASH_SOURCE[0]}")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

requireEnvironments=(DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS APPLICATION_ID)

usageDescription() {
  cat <<EOF

Need environment: $(consoleValue "${requireEnvironments[*]}")
EOF
}

#
# Undeploy in pipeline.
#
# The environment variables outlined here must be defined in the environment or the `.build.env` file.
#
# fn: {base}
# Usage: {fn}
# Environment: APPLICATION_ID - Required. App unique ID
# Environment: DEPLOY_REMOTE_PATH - Required. Deployment home directory on remote
# Environment: APPLICATION_REMOTE_PATH - Required. Application home directory on remote
# Environment: DEPLOY_USER_HOSTS - Required. user@host list
#
_undeployUsage() {
  usageDocument "bin/build/pipeline/$me" _undeployUsage "$@"
  return $?
}

if [ ! -f .build.env ]; then
  consoleWarning "No .build.env found" 1>&2
else
  set -a
  # shellcheck source=/dev/null
  . .build.env
  set +a
fi

if ! usageRequireEnvironment _undeployUsage "${requireEnvironments[@]}"; then
  return $?
fi

./bin/build/pipeline/deploy-to.sh --revert "$APPLICATION_ID" "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"
