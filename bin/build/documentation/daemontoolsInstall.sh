#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
description="Install daemontools and dependencies"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsInstall"
foundNames=([0]="platform")
line="12"
lowerFn="daemontoolsinstall"
platform="\`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""
rawComment="Install daemontools and dependencies"$'\n'"Platform: \`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="e296fb9d01433db9953e64db6fec0b0163eab875"
sourceLine="12"
summary="Install daemontools and dependencies"
summaryComputed="true"
usage="daemontoolsInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsInstall'$'\e''[0m'$'\n'''$'\n''Install daemontools and dependencies'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsInstall'$'\n'''$'\n''Install daemontools and dependencies'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/daemontools.md"
