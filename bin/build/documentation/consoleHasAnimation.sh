#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="none"
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does the console support animation?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="consoleHasAnimation"
fnMarker="consolehasanimation"
foundNames=([0]="return_code")
line="55"
rawComment="Does the console support animation?"$'\n'"Return Code: 0 - Supports console animation"$'\n'"Return Code: 1 - Does not support console animation"$'\n'""$'\n'""
return_code="0 - Supports console animation"$'\n'"1 - Does not support console animation"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="07796ffc2b7321ebd8b87945b7b797d05510cb69"
sourceLine="55"
summary="Does the console support animation?"
summaryComputed="true"
usage="consoleHasAnimation"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleHasAnimation'$'\e''[0m'$'\n'''$'\n''Does the console support animation?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Supports console animation'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Does not support console animation'
# shellcheck disable=SC2016
helpPlain='Usage: consoleHasAnimation'$'\n'''$'\n''Does the console support animation?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Supports console animation'$'\n''- 1 - Does not support console animation'
documentationPath="documentation/source/tools/decorate.md"
