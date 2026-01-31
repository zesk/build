#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--timeout seconds - Integer. Optional."$'\n'""
base="daemontools.sh"
description="Terminate daemontools as gracefully as possible"$'\n'""
file="bin/build/tools/daemontools.sh"
foundNames=([0]="argument" [1]="requires")
rawComment="Terminate daemontools as gracefully as possible"$'\n'"Argument: --timeout seconds - Integer. Optional."$'\n'"Requires: throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment validate statusMessage"$'\n'"Requires: svscanboot id svc svstat"$'\n'""$'\n'""
requires="throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment validate statusMessage"$'\n'"svscanboot id svc svstat"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="ad7724ecae1a0dfef00687192388ecf23b24032c"
summary="Terminate daemontools as gracefully as possible"
summaryComputed="true"
usage="daemontoolsTerminate [ --timeout seconds ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsTerminate'$'\e''[0m '$'\e''[[(blue)]m[ --timeout seconds ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--timeout seconds  '$'\e''[[(value)]mInteger. Optional.'$'\e''[[(reset)]m'$'\n'''$'\n''Terminate daemontools as gracefully as possible'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsTerminate [ --timeout seconds ]'$'\n'''$'\n''    --timeout seconds  Integer. Optional.'$'\n'''$'\n''Terminate daemontools as gracefully as possible'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
