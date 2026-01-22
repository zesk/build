#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apk.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"--env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"--platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"extraArgs - Mixed. Optional. The first non-file argument to \`alpineContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="apk.sh"
description="Open an Alpine container shell"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'""
file="bin/build/tools/apk.sh"
fn="alpineContainer"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apk.sh"
sourceModified="1768721469"
summary="Open an Alpine container shell"
usage="alpineContainer [ --help ] [ --env-file envFile ] [ --env envVariable=envValue ] [ --platform platform ] [ extraArgs ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255malpineContainer[0m [94m[ --help ][0m [94m[ --env-file envFile ][0m [94m[ --env envVariable=envValue ][0m [94m[ --platform platform ][0m [94m[ extraArgs ][0m

    [94m--help                      [1;97mFlag. Optional. Display this help.[0m
    [94m--env-file envFile          [1;97mFile. Optional. One or more environment files which are suitable to load for docker; must be valid[0m
    [94m--env envVariable=envValue  [1;97mFile. Optional. One or more environment variables to set.[0m
    [94m--platform platform         [1;97mString. Optional. Platform to run (arm vs intel).[0m
    [94mextraArgs                   [1;97mMixed. Optional. The first non-file argument to [38;2;0;255;0;48;2;0;0;0malpineContainer[0m is passed directly through to [38;2;0;255;0;48;2;0;0;0mdocker run[0m as arguments[0m

Open an Alpine container shell
Return Code: 1 - If already inside docker, or the environment file passed is not valid
Return Code: 0 - Success
Return Code: Any - [38;2;0;255;0;48;2;0;0;0mdocker run[0m error code is returned if non-zero

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: alpineContainer [ --help ] [ --env-file envFile ] [ --env envVariable=envValue ] [ --platform platform ] [ extraArgs ]

    --help                      Flag. Optional. Display this help.
    --env-file envFile          File. Optional. One or more environment files which are suitable to load for docker; must be valid
    --env envVariable=envValue  File. Optional. One or more environment variables to set.
    --platform platform         String. Optional. Platform to run (arm vs intel).
    extraArgs                   Mixed. Optional. The first non-file argument to alpineContainer is passed directly through to docker run as arguments

Open an Alpine container shell
Return Code: 1 - If already inside docker, or the environment file passed is not valid
Return Code: 0 - Success
Return Code: Any - docker run error code is returned if non-zero

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
