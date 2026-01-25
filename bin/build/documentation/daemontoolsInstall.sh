#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="none"
base="daemontools.sh"
description="Install daemontools and dependencies"$'\n'""
exitCode="0"
file="bin/build/tools/daemontools.sh"
foundNames=([0]="platform")
platform="\`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""
rawComment="Install daemontools and dependencies"$'\n'"Platform: \`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769109690"
summary="Install daemontools and dependencies"
usage="daemontoolsInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdaemontoolsInstall'$'\e''[0m'$'\n'''$'\n''Install daemontools and dependencies'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsInstall'$'\n'''$'\n''Install daemontools and dependencies'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
