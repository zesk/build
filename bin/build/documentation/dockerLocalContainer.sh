#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--image imageName - String. Optional. Docker image name to run. Defaults to \`BUILD_DOCKER_IMAGE\`."$'\n'"--path imageApplicationPath - Path. Docker image path to map to current directory. Defaults to \`BUILD_DOCKER_PATH\`."$'\n'"--platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"--env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"--env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"extraArgs - Mixed. Optional. The first non-file argument to \`dockerLocalContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="docker.sh"
description="Run a build container using given docker image."$'\n'""$'\n'"Runs ARM64 by default."$'\n'""$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'""$'\n'""
environment="BUILD_DOCKER_PLATFORM - Optional. Defaults to \`linux/arm64\`. Affects which image platform is used."$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerLocalContainer"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/docker.sh"
sourceModified="1768721469"
summary="Run a build container using given docker image."
usage="dockerLocalContainer [ --help ] [ --handler handler ] [ --image imageName ] [ --path imageApplicationPath ] [ --platform platform ] [ --env-file envFile ] [ --env envVariable=envValue ] [ extraArgs ]"
