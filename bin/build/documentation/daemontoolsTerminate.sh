#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-03
# shellcheck disable=SC2034
argument=$'--timeout seconds - Integer. Optional.\n'
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Terminate daemontools as gracefully as possible\n\n'
descriptionLineCount="2"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsTerminate"
fnMarker="daemontoolsterminate"
foundNames=([0]="argument" [1]="requires")
line="333"
rawComment=$'Terminate daemontools as gracefully as possible\nArgument: --timeout seconds - Integer. Optional.\nRequires: throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment validate statusMessage\nRequires: svscanboot id svc svstat\n\n'
requires=$'throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment validate statusMessage\nsvscanboot id svc svstat\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="e7272ea2b43766f6539702f962a0e5b92c54b968"
sourceLine="333"
summary="Terminate daemontools as gracefully as possible"
summaryComputed="true"
usage="daemontoolsTerminate [ --timeout seconds ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsTerminate'$'\e''[0m '$'\e''[[(blue)]m[ --timeout seconds ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--timeout seconds  '$'\e''[[(value)]mInteger. Optional.'$'\e''[[(reset)]m'$'\n'''$'\n''Terminate daemontools as gracefully as possible'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsTerminate [ --timeout seconds ]'$'\n'''$'\n''    --timeout seconds  Integer. Optional.'$'\n'''$'\n''Terminate daemontools as gracefully as possible'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/daemontools.md"
