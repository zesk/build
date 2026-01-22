#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bitbucket.sh"
argument="envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid"$'\n'"extraArgs ... - Arguments. Optional. The first non-file argument to \`bitbucketContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="bitbucket.sh"
description="Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'"Run the default build container for build testing on BitBucket"$'\n'""
file="bin/build/tools/bitbucket.sh"
fn="bitbucketContainer"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceModified="1769063211"
summary="Return Code: 1 - If already inside docker, or the"
updated="2026-01-15"$'\n'""
usage="bitbucketContainer envFile [ extraArgs ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbitbucketContainer[0m [38;2;255;255;0m[35;48;2;0;0;0menvFile[0m[0m [94m[ extraArgs ... ][0m

    [31menvFile        [1;97mFile. Required. One or more environment files which are suitable to load for docker; must be valid[0m
    [94mextraArgs ...  [1;97mArguments. Optional. The first non-file argument to [38;2;0;255;0;48;2;0;0;0mbitbucketContainer[0m is passed directly through to [38;2;0;255;0;48;2;0;0;0mdocker run[0m as arguments[0m

Return Code: 1 - If already inside docker, or the environment file passed is not valid
Return Code: 0 - Success
Return Code: Any - [38;2;0;255;0;48;2;0;0;0mdocker run[0m error code is returned if non-zero
Run the default build container for build testing on BitBucket

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bitbucketContainer envFile [ extraArgs ... ]

    envFile        File. Required. One or more environment files which are suitable to load for docker; must be valid
    extraArgs ...  Arguments. Optional. The first non-file argument to bitbucketContainer is passed directly through to docker run as arguments

Return Code: 1 - If already inside docker, or the environment file passed is not valid
Return Code: 0 - Success
Return Code: Any - docker run error code is returned if non-zero
Run the default build container for build testing on BitBucket

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
