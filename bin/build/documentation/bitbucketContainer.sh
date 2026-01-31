#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid"$'\n'"extraArgs ... - Arguments. Optional. The first non-file argument to \`bitbucketContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="bitbucket.sh"
description="Run the default build container for build testing on BitBucket"$'\n'""
file="bin/build/tools/bitbucket.sh"
foundNames=([0]="argument" [1]="return_code" [2]="updated")
rawComment="Argument: envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid"$'\n'"Argument: extraArgs ... - Arguments. Optional. The first non-file argument to \`{fn}\` is passed directly through to \`docker run\` as arguments"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'"Run the default build container for build testing on BitBucket"$'\n'"Updated: 2026-01-15"$'\n'""$'\n'""
return_code="1 - If already inside docker, or the environment file passed is not valid"$'\n'"0 - Success"$'\n'"Any - \`docker run\` error code is returned if non-zero"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="4a421c2dcbbf58af3dd11352be2e5851420ecd17"
summary="Run the default build container for build testing on BitBucket"
summaryComputed="true"
updated="2026-01-15"$'\n'""
usage="bitbucketContainer envFile [ extraArgs ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbitbucketContainer'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]menvFile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ extraArgs ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]menvFile        '$'\e''[[(value)]mFile. Required. One or more environment files which are suitable to load for docker; must be valid'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mextraArgs ...  '$'\e''[[(value)]mArguments. Optional. The first non-file argument to '$'\e''[[(code)]mbitbucketContainer'$'\e''[[(reset)]m is passed directly through to '$'\e''[[(code)]mdocker run'$'\e''[[(reset)]m as arguments'$'\e''[[(reset)]m'$'\n'''$'\n''Run the default build container for build testing on BitBucket'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If already inside docker, or the environment file passed is not valid'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]mAny'$'\e''[[(reset)]m - '$'\e''[[(code)]mdocker run'$'\e''[[(reset)]m error code is returned if non-zero'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bitbucketContainer envFile [[(blue)]m[ extraArgs ... ]'$'\n'''$'\n''    envFile        File. Required. One or more environment files which are suitable to load for docker; must be valid'$'\n''    [[(blue)]mextraArgs ...  Arguments. Optional. The first non-file argument to bitbucketContainer is passed directly through to docker run as arguments'$'\n'''$'\n''Run the default build container for build testing on BitBucket'$'\n'''$'\n''Return codes:'$'\n''- 1 - If already inside docker, or the environment file passed is not valid'$'\n''- 0 - Success'$'\n''- Any - docker run error code is returned if non-zero'$'\n'''
# elapsed 4.16
