#!/bin/bash
#
# Local local container to test build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

#shellcheck source=/dev/null
. ./bin/build/tools.sh

if insideDocker; then
    consoleError "Already inside docker"
    exit 1
fi
docker run --platform linux/arm64 -v "$(pwd):/opt/atlassian/bitbucketci/agent/build" -it atlassian/default-image:4
