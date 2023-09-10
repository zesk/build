#!/usr/bin/env bash
#
# Undeploy an application
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

errEnv=1
# errArg=2
set -eo pipefail
# set -x # Debugging

relTop=../..
me=$(basename "${BASH_SOURCE[0]}")
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

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

bin/build/pipeline/pipeline-deploy-to.sh --undo "$DEPLOY_REMOTE_PATH" "$APPLICATION_REMOTE_PATH" "$DEPLOY_USER_HOSTS"
