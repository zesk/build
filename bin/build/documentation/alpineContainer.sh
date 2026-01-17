#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apk.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"--env-file envFile -  File. Optional.One or more environment files which are suitable to load for docker; must be valid"$'\n'"--env envVariable=envValue -  File. Optional.One or more environment variables to set."$'\n'"--platform platform - String. Optional. Platform to run (arm vs intel)."$'\n'"extraArgs -  Mixed. Optional.The first non-file argument to \`alpineContainer\` is passed directly through to \`docker run\` as arguments"$'\n'""
base="apk.sh"
description="Open an Alpine container shell"$'\n'"Return Code: 1 - If already inside docker, or the environment file passed is not valid"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: Any - \`docker run\` error code is returned if non-zero"$'\n'""
file="bin/build/tools/apk.sh"
fn="alpineContainer"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/apk.sh"
sourceModified="1768683825"
summary="Open an Alpine container shell"
usage="alpineContainer [ --help ] [ --env-file envFile ] [ --env envVariable=envValue ] [ --platform platform ] [ extraArgs ]"
