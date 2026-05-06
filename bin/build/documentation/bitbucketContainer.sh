#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid"$'\n'"extraArgs ... - Arguments. Optional. The first non-file argument to \`bitbucketContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="bitbucket.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run the default build container for build testing on BitBucket"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bitbucket.sh"
fn="bitbucketContainer"
fnMarker="bitbucketcontainer"
foundNames=([0]="argument" [1]="return_code" [2]="updated")
line="66"
rawComment="Argument: envFile - File. Required. One or more environment files which are suitable to load for docker; must be valid"$'\n'"Argument: extraArgs ... - Arguments. Optional. The first non-file argument to \`{fn}\` is passed directly through to \`docker run\` as arguments"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'"Run the default build container for build testing on BitBucket"$'\n'"Updated: 2026-01-15"$'\n'""$'\n'""
return_code="1 - If already inside docker, or the environment file passed is not valid"$'\n'"0 - Success"$'\n'"Any - \`docker run\` error code is returned if non-zero"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="1f4c241b99592c40a01d7716c3276a12de251352"
sourceLine="66"
summary="Run the default build container for build testing on BitBucket"
summaryComputed="true"
updated="2026-01-15"$'\n'""
usage="bitbucketContainer envFile [ extraArgs ... ]"
