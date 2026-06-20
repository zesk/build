#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Determine the default package manager on this platform.\nOutput is one of:\n- apk apt brew port\n\n'
descriptionLineCount="4"
file="bin/build/tools/package.sh"
fn="packageManagerDefault"
fnMarker="packagemanagerdefault"
foundNames=()
line="624"
original="packageManagerDefault"
rawComment=$'Determine the default package manager on this platform.\nOutput is one of:\n- apk apt brew port\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="3044284fc1f27bf20924a72ed04c7da3af05f86f"
sourceLine="624"
summary="Determine the default package manager on this platform."
summaryComputed="true"
usage="packageManagerDefault"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageManagerDefault'$'\e''[0m'$'\n'''$'\n''Determine the default package manager on this platform.'$'\n''Output is one of:'$'\n''- apk apt brew port'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: packageManagerDefault'$'\n'''$'\n''Determine the default package manager on this platform.'$'\n''Output is one of:'$'\n''- apk apt brew port'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/package.md"
