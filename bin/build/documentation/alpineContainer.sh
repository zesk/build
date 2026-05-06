#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"--env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"--platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"extraArgs - Mixed. Optional. The first non-file argument to \`alpineContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="apk.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Open an Alpine container shell"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/apk.sh"
fn="alpineContainer"
fnMarker="alpinecontainer"
foundNames=([0]="argument" [1]="return_code")
line="50"
rawComment="Open an Alpine container shell"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"Argument: --env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"Argument: --platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"Argument: extraArgs - Mixed. Optional. The first non-file argument to \`{fn}\` is passed directly through to \`docker run\` as arguments"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'""$'\n'""
return_code="1 - If already inside docker, or the environment file passed is not valid"$'\n'"0 - Success"$'\n'"Any - \`docker run\` error code is returned if non-zero"$'\n'""
sourceFile="bin/build/tools/apk.sh"
sourceHash="5bdc3f7dc0004f26659cab9392460974cb8a949b"
sourceLine="50"
summary="Open an Alpine container shell"
summaryComputed="true"
usage="alpineContainer [ --help ] [ --env-file envFile ] [ --env envVariable=envValue ] [ --platform platform ] [ extraArgs ]"
