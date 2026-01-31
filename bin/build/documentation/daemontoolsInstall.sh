#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
description="Install daemontools and dependencies"$'\n'""
file="bin/build/tools/daemontools.sh"
foundNames=([0]="platform")
platform="\`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""
rawComment="Install daemontools and dependencies"$'\n'"Platform: \`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="ad7724ecae1a0dfef00687192388ecf23b24032c"
summary="Install daemontools and dependencies"
summaryComputed="true"
usage="daemontoolsInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsInstall'$'\e''[0m'$'\n'''$'\n''Install daemontools and dependencies'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mdaemontoolsInstall'$'\n'''$'\n''Install daemontools and dependencies'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''
# elapsed 3.626
