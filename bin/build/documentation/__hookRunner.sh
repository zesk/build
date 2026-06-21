#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="hook.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Actual implementation of `hookRun` and `hookRunOptional`\n\n'
descriptionLineCount="2"
file="bin/build/tools/hook.sh"
fn="__hookRunner"
fnMarker="__hookrunner"
foundNames=([0]="see")
line="13"
original="__hookRunner"
rawComment=$'Actual implementation of `hookRun` and `hookRunOptional`\nSee: hookRun hookRunOptional hookSource hookSourceOptional\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'hookRun hookRunOptional hookSource hookSourceOptional\n'
sourceFile="bin/build/tools/hook.sh"
sourceHash="d7e5ca8901bb43435b977751cbb2ef47e4b94072"
sourceLine="13"
summary="Actual implementation of \`hookRun\` and \`hookRunOptional\`"
summaryComputed="true"
usage="__hookRunner"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__hookRunner'$'\e''[0m'$'\n'''$'\n''Actual implementation of '$'\e''[[(code)]mhookRun'$'\e''[[(reset)]m and '$'\e''[[(code)]mhookRunOptional'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __hookRunner'$'\n'''$'\n''Actual implementation of hookRun and hookRunOptional'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
