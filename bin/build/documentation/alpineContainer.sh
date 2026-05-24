#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid\n--env envVariable=envValue - File. Optional. One or more environment variables to set.\n--platform platform - String. Optional. Platform to run (arm vs intel).\nextraArgs - Mixed. Optional. The first non-file argument to `alpineContainer` is passed directly through to `docker run` as arguments\n'
base="apk.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Open an Alpine container shell\n\n'
descriptionLineCount="2"
file="bin/build/tools/apk.sh"
fn="alpineContainer"
fnMarker="alpinecontainer"
foundNames=([0]="argument" [1]="return_code")
line="50"
rawComment=$'Open an Alpine container shell\nArgument: --help - Flag. Optional. Display this help.\nArgument: --env-file envFile - File. Optional. One or more environment files which are suitable to load for docker; must be valid\nArgument: --env envVariable=envValue - File. Optional. One or more environment variables to set.\nArgument: --platform platform - String. Optional. Platform to run (arm vs intel).\nArgument: extraArgs - Mixed. Optional. The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments\nReturn Code: 1 - If already inside docker, or the environment file passed is not valid\nReturn Code: 0 - Success\nReturn Code: Any - `docker run` error code is returned if non-zero\n\n'
return_code=$'1 - If already inside docker, or the environment file passed is not valid\n0 - Success\nAny - `docker run` error code is returned if non-zero\n'
sourceFile="bin/build/tools/apk.sh"
sourceHash="92aca540203b07d09d3e678e98cbe97a1ecce081"
sourceLine="50"
summary="Open an Alpine container shell"
summaryComputed="true"
usage="alpineContainer [ --help ] [ --env-file envFile ] [ --env envVariable=envValue ] [ --platform platform ] [ extraArgs ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]malpineContainer'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --env-file envFile ]'$'\e''[0m '$'\e''[[(blue)]m[ --env envVariable=envValue ]'$'\e''[0m '$'\e''[[(blue)]m[ --platform platform ]'$'\e''[0m '$'\e''[[(blue)]m[ extraArgs ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--env-file envFile          '$'\e''[[(value)]mFile. Optional. One or more environment files which are suitable to load for docker; must be valid'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--env envVariable=envValue  '$'\e''[[(value)]mFile. Optional. One or more environment variables to set.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--platform platform         '$'\e''[[(value)]mString. Optional. Platform to run (arm vs intel).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mextraArgs                   '$'\e''[[(value)]mMixed. Optional. The first non-file argument to '$'\e''[[(code)]malpineContainer'$'\e''[[(reset)]m is passed directly through to '$'\e''[[(code)]mdocker run'$'\e''[[(reset)]m as arguments'$'\e''[[(reset)]m'$'\n'''$'\n''Open an Alpine container shell'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If already inside docker, or the environment file passed is not valid'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]mAny'$'\e''[[(reset)]m - '$'\e''[[(code)]mdocker run'$'\e''[[(reset)]m error code is returned if non-zero'
# shellcheck disable=SC2016
helpPlain='Usage: alpineContainer [ --help ] [ --env-file envFile ] [ --env envVariable=envValue ] [ --platform platform ] [ extraArgs ]'$'\n'''$'\n''    --help                      Flag. Optional. Display this help.'$'\n''    --env-file envFile          File. Optional. One or more environment files which are suitable to load for docker; must be valid'$'\n''    --env envVariable=envValue  File. Optional. One or more environment variables to set.'$'\n''    --platform platform         String. Optional. Platform to run (arm vs intel).'$'\n''    extraArgs                   Mixed. Optional. The first non-file argument to alpineContainer is passed directly through to docker run as arguments'$'\n'''$'\n''Open an Alpine container shell'$'\n'''$'\n''Return codes:'$'\n''- 1 - If already inside docker, or the environment file passed is not valid'$'\n''- 0 - Success'$'\n''- Any - docker run error code is returned if non-zero'
documentationPath="documentation/source/tools/apk.md"
