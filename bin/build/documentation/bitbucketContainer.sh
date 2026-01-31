#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bitbucket.sh"
description="Argument: envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid"$'\n'"Argument: extraArgs ... - Arguments. Optional. The first non-file argument to \`{fn}\` is passed directly through to \`docker run\` as arguments"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'"Run the default build container for build testing on BitBucket"$'\n'"Updated: 2026-01-15"$'\n'""
file="bin/build/tools/bitbucket.sh"
foundNames=()
rawComment="Argument: envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid"$'\n'"Argument: extraArgs ... - Arguments. Optional. The first non-file argument to \`{fn}\` is passed directly through to \`docker run\` as arguments"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'"Run the default build container for build testing on BitBucket"$'\n'"Updated: 2026-01-15"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="4a421c2dcbbf58af3dd11352be2e5851420ecd17"
summary="Argument: envFile - File. Required. One or more environment files"
usage="bitbucketContainer"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbitbucketContainer'$'\e''[0m'$'\n'''$'\n''Argument: envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid'$'\n''Argument: extraArgs ... - Arguments. Optional. The first non-file argument to '$'\e''[[(code)]mbitbucketContainer'$'\e''[[(reset)]m is passed directly through to '$'\e''[[(code)]mdocker run'$'\e''[[(reset)]m as arguments'$'\n''Return Code: 1 - If already inside docker, or the environment file passed is not valid'$'\n''Return Code: 0 - Success'$'\n''Return Code: Any - '$'\e''[[(code)]mdocker run'$'\e''[[(reset)]m error code is returned if non-zero'$'\n''Run the default build container for build testing on BitBucket'$'\n''Updated: 2026-01-15'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bitbucketContainer'$'\n'''$'\n''Argument: envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid'$'\n''Argument: extraArgs ... - Arguments. Optional. The first non-file argument to bitbucketContainer is passed directly through to docker run as arguments'$'\n''Return Code: 1 - If already inside docker, or the environment file passed is not valid'$'\n''Return Code: 0 - Success'$'\n''Return Code: Any - docker run error code is returned if non-zero'$'\n''Run the default build container for build testing on BitBucket'$'\n''Updated: 2026-01-15'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.44
