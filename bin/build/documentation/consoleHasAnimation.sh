#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="none"
base="colors.sh"
description="Does the console support animation?"$'\n'""
file="bin/build/tools/colors.sh"
foundNames=([0]="return_code")
rawComment="Does the console support animation?"$'\n'"Return Code: 0 - Supports console animation"$'\n'"Return Code: 1 - Does not support console animation"$'\n'""$'\n'""
return_code="0 - Supports console animation"$'\n'"1 - Does not support console animation"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="9f54e9ae3d6bd1960826e3412b3edfd9c241f895"
summary="Does the console support animation?"
summaryComputed="true"
usage="consoleHasAnimation"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleHasAnimation'$'\e''[0m'$'\n'''$'\n''Does the console support animation?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Supports console animation'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Does not support console animation'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleHasAnimation'$'\n'''$'\n''Does the console support animation?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Supports console animation'$'\n''- 1 - Does not support console animation'$'\n'''
