#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--image imageName - String. Optional. Docker image name to run. Defaults to \`BUILD_DOCKER_IMAGE\`."$'\n'"--path imageApplicationPath - Path. Docker image path to map to current directory. Defaults to \`BUILD_DOCKER_PATH\`."$'\n'"--platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"--env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"--env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"extraArgs - Mixed. Optional. The first non-file argument to \`dockerLocalContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="docker.sh"
description="Run a build container using given docker image."$'\n'""$'\n'"Runs ARM64 by default."$'\n'""$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'"- \`BUILD_DOCKER_PLATFORM\` defaults to \`linux/arm64\` – affects which image platform is used."$'\n'""
environment="BUILD_DOCKER_PLATFORM"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerLocalContainer"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceModified="1768759328"
summary="Run a build container using given docker image."
usage="dockerLocalContainer [ --help ] [ --handler handler ] [ --image imageName ] [ --path imageApplicationPath ] [ --platform platform ] [ --env-file envFile ] [ --env envVariable=envValue ] [ extraArgs ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerLocalContainer[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --image imageName ][0m [94m[ --path imageApplicationPath ][0m [94m[ --platform platform ][0m [94m[ --env-file envFile ][0m [94m[ --env envVariable=envValue ][0m [94m[ extraArgs ][0m

    [94m--help                       [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler            [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--image imageName            [1;97mString. Optional. Docker image name to run. Defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_DOCKER_IMAGE[0m.[0m
    [94m--path imageApplicationPath  [1;97mPath. Docker image path to map to current directory. Defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_DOCKER_PATH[0m.[0m
    [94m--platform platform          [1;97mString. Optional. Platform to run (arm vs intel).[0m
    [94m--env-file envFile           [1;97mFile. Optional. One or more environment files which are suitable to load for docker; must be valid[0m
    [94m--env envVariable=envValue   [1;97mFile. Optional. One or more environment variables to set.[0m
    [94mextraArgs                    [1;97mMixed. Optional. The first non-file argument to [38;2;0;255;0;48;2;0;0;0mdockerLocalContainer[0m is passed directly through to [38;2;0;255;0;48;2;0;0;0mdocker run[0m as arguments[0m

Run a build container using given docker image.

Runs ARM64 by default.

Return Code: 1 - If already inside docker, or the environment file passed is not valid
Return Code: 0 - Success
Return Code: Any - [38;2;0;255;0;48;2;0;0;0mdocker run[0m error code is returned if non-zero
- [38;2;0;255;0;48;2;0;0;0mBUILD_DOCKER_PLATFORM[0m defaults to [38;2;0;255;0;48;2;0;0;0mlinux/arm64[0m – affects which image platform is used.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DOCKER_PLATFORM
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerLocalContainer [ --help ] [ --handler handler ] [ --image imageName ] [ --path imageApplicationPath ] [ --platform platform ] [ --env-file envFile ] [ --env envVariable=envValue ] [ extraArgs ]

    --help                       Flag. Optional. Display this help.
    --handler handler            Function. Optional. Use this error handler instead of the default error handler.
    --image imageName            String. Optional. Docker image name to run. Defaults to BUILD_DOCKER_IMAGE.
    --path imageApplicationPath  Path. Docker image path to map to current directory. Defaults to BUILD_DOCKER_PATH.
    --platform platform          String. Optional. Platform to run (arm vs intel).
    --env-file envFile           File. Optional. One or more environment files which are suitable to load for docker; must be valid
    --env envVariable=envValue   File. Optional. One or more environment variables to set.
    extraArgs                    Mixed. Optional. The first non-file argument to dockerLocalContainer is passed directly through to docker run as arguments

Run a build container using given docker image.

Runs ARM64 by default.

Return Code: 1 - If already inside docker, or the environment file passed is not valid
Return Code: 0 - Success
Return Code: Any - docker run error code is returned if non-zero
- BUILD_DOCKER_PLATFORM defaults to linux/arm64 – affects which image platform is used.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DOCKER_PLATFORM
- 
'
