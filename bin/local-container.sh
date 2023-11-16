#!/bin/bash
#
# Local local container to test build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if [ ! -d ./bin/build ]; then
    ./bin/install-bin-build.sh
fi
#shellcheck source=/dev/null
. ./bin/build/tools.sh

if insideDocker; then
    consoleError "Already inside docker"
    exit 1
fi
envFiles=()
extraArgs=()
while [ $# -gt 0 ]; do
    if [ -f "$1" ]; then
        if ! checkDockerEnvFile "$1" 2>/dev/null; then
            consoleError "Invalid docker env file: $1$(consoleCode)" 1>&2
            (checkDockerEnvFile "$1" 2>&1 || :) | prefixLines "$(consoleCode)     " 1>&2
            printf %s "$(consoleReset)"
            clearLine
            exit 1
        fi
        envFiles+=("--env-file" "$1")
    else
        extraArgs+=("$1")
    fi
    shift
done
docker run "${envFiles[@]}" --platform linux/arm64 -v "$(pwd):/opt/atlassian/bitbucketci/agent/build" -it atlassian/default-image:4 "${extraArgs[@]}"
