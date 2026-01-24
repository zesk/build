#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apk.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"--env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"--platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"extraArgs - Mixed. Optional. The first non-file argument to \`alpineContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="apk.sh"
description="Open an Alpine container shell"$'\n'""
exitCode="0"
file="bin/build/tools/apk.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Open an Alpine container shell"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid"$'\n'"Argument: --env envVariable=envValue - File. Optional. One or more environment variables to set."$'\n'"Argument: --platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"Argument: extraArgs - Mixed. Optional. The first non-file argument to \`{fn}\` is passed directly through to \`docker run\` as arguments"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'""$'\n'""
return_code="1 - If already inside docker, or the environment file passed is not valid"$'\n'"0 - Success"$'\n'"Any - \`docker run\` error code is returned if non-zero"$'\n'""
sourceFile="bin/build/tools/apk.sh"
sourceModified="1769184734"
summary="Open an Alpine container shell"
usage="alpineContainer [ --help ] [ --env-file envFile ] [ --env envVariable=envValue ] [ --platform platform ] [ extraArgs ]"
