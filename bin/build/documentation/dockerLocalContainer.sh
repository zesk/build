#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--image imageName - String. Optional. Docker image name to run. Defaults to \`BUILD_DOCKER_IMAGE\`."$'\n'"--path imageApplicationPath - Path. Docker image path to map to current directory. Defaults to \`BUILD_DOCKER_PATH\`."$'\n'"--platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"--env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"--env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"extraArgs - Mixed. Optional. The first non-file argument to \`dockerLocalContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a build container using given docker image."$'\n'""$'\n'"Runs ARM64 by default."$'\n'""$'\n'"- \`BUILD_DOCKER_PLATFORM\` defaults to \`linux/arm64\` – affects which image platform is used."$'\n'""$'\n'""
descriptionLineCount="6"
environment="BUILD_DOCKER_PLATFORM"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerLocalContainer"
fnMarker="dockerlocalcontainer"
foundNames=([0]="argument" [1]="return_code" [2]="environment")
line="117"
rawComment="Run a build container using given docker image."$'\n'"Runs ARM64 by default."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --image imageName - String. Optional. Docker image name to run. Defaults to \`BUILD_DOCKER_IMAGE\`."$'\n'"Argument: --path imageApplicationPath - Path. Docker image path to map to current directory. Defaults to \`BUILD_DOCKER_PATH\`."$'\n'"Argument: --platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"Argument: --env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"Argument: --env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"Argument: extraArgs - Mixed. Optional. The first non-file argument to \`{fn}\` is passed directly through to \`docker run\` as arguments"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'"Environment: BUILD_DOCKER_PLATFORM"$'\n'"- \`BUILD_DOCKER_PLATFORM\` defaults to \`linux/arm64\` – affects which image platform is used."$'\n'""$'\n'""
return_code="1 - If already inside docker, or the environment file passed is not valid"$'\n'"0 - Success"$'\n'"Any - \`docker run\` error code is returned if non-zero"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="7ff1d9ef9d41486d9537ae6db40de4176c5794ab"
sourceLine="117"
summary="Run a build container using given docker image."
summaryComputed="true"
usage="dockerLocalContainer [ --help ] [ --handler handler ] [ --image imageName ] [ --path imageApplicationPath ] [ --platform platform ] [ --env-file envFile ] [ --env envVariable=envValue ] [ extraArgs ]"
