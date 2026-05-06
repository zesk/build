#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="vendor.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Show the current editor being used as a text string"$'\n'""$'\n'""
descriptionLineCount="2"
environment="EDITOR - Used as a default editor (first)"$'\n'"VISUAL - Used as another default editor (last)"$'\n'""
file="bin/build/tools/vendor.sh"
fn="contextShow"
fnMarker="contextshow"
foundNames=([0]="return_code" [1]="environment")
line="104"
rawComment="Show the current editor being used as a text string"$'\n'"Return Code: 1 - If no editor or running program can be determined"$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'""$'\n'""
return_code="1 - If no editor or running program can be determined"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="6a1c6758472ed8ae9048cda1a9a026cbbe718421"
sourceLine="104"
summary="Show the current editor being used as a text string"
summaryComputed="true"
usage="contextShow"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcontextShow'$'\e''[0m'$'\n'''$'\n''Show the current editor being used as a text string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If no editor or running program can be determined'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mEDITOR'$'\e''[[(reset)]m - Used as a default editor (first)'$'\n''- '$'\e''[[(code)]mVISUAL'$'\e''[[(reset)]m - Used as another default editor (last)'
# shellcheck disable=SC2016
helpPlain='Usage: contextShow'$'\n'''$'\n''Show the current editor being used as a text string'$'\n'''$'\n''Return codes:'$'\n''- 1 - If no editor or running program can be determined'$'\n'''$'\n''Environment variables:'$'\n''- EDITOR - Used as a default editor (first)'$'\n''- VISUAL - Used as another default editor (last)'
documentationPath="documentation/source/tools/vendor.md"
