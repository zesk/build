#!/usr/bin/env bash
#
# Undeploy an application
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eo pipefail
# set -x # Debugging

me=$(basename "${BASH_SOURCE[0]}")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

requireEnvironments=(DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS APPLICATION_CHECKSUM)

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
    consoleInfo "Undeploy in pipeline"
    echo
    consoleInfo "Need environment ${requireEnvironments[*]}"
    exit "$rs"
}

if [ ! -f .build.env ]; then
    consoleWarning "No .build.env found" 1>&2
else
    # shellcheck source=/dev/null
    set -a && . .build.env
fi

usageEnvironment "${requireEnvironments[@]}"

./bin/build/pipeline/deploy-to.sh --undo "$APPLICATION_CHECKSUM" "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"
