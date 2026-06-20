#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'usageFunction - Required. `bash` function already defined to output handler\nbinary - Required. Binary which must have a `which` path.\n'
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Requires the binaries to be found via `which`\n\nRuns `handler` on failure\n\n'
descriptionLineCount="4"
file="bin/build/tools/usage.sh"
fn="executableRequire"
fnMarker="executablerequire"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="232"
original="executableRequire"
rawComment=$'Summary: Check that one or more binaries are installed\nArgument: usageFunction - Required. `bash` function already defined to output handler\nArgument: binary - Required. Binary which must have a `which` path.\nReturn Code: 1 - If any `binary` is not available within the current path\nRequires the binaries to be found via `which`\nRuns `handler` on failure\n\n'
return_code=$'1 - If any `binary` is not available within the current path\n'
sourceFile="bin/build/tools/usage.sh"
sourceHash="01b6c3e63321ac7c7af6eceb919864c8294945e5"
sourceLine="232"
summary="Check that one or more binaries are installed"
summaryComputed=""
usage="executableRequire usageFunction binary"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecutableRequire'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]musageFunction'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]musageFunction  '$'\e''[[(value)]mRequired. '$'\e''[[(code)]mbash'$'\e''[[(reset)]m function already defined to output handler'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mbinary         '$'\e''[[(value)]mRequired. Binary which must have a '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m path.'$'\e''[[(reset)]m'$'\n'''$'\n''Requires the binaries to be found via '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m'$'\n'''$'\n''Runs '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m on failure'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If any '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m is not available within the current path'
# shellcheck disable=SC2016
helpPlain='Usage: executableRequire usageFunction binary'$'\n'''$'\n''    usageFunction  Required. bash function already defined to output handler'$'\n''    binary         Required. Binary which must have a which path.'$'\n'''$'\n''Requires the binaries to be found via which'$'\n'''$'\n''Runs handler on failure'$'\n'''$'\n''Return codes:'$'\n''- 1 - If any binary is not available within the current path'
documentationPath="documentation/source/tools/usage.md"
