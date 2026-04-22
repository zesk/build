#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="vendor.sh"
description="Show the current editor being used as a text string"$'\n'""
environment="EDITOR - Used as a default editor (first)"$'\n'"VISUAL - Used as another default editor (last)"$'\n'""
file="bin/build/tools/vendor.sh"
fn="contextShow"
foundNames=([0]="return_code" [1]="environment")
line="104"
lowerFn="contextshow"
rawComment="Show the current editor being used as a text string"$'\n'"Return Code: 1 - If no editor or running program can be determined"$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'""$'\n'""
return_code="1 - If no editor or running program can be determined"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="6a1c6758472ed8ae9048cda1a9a026cbbe718421"
sourceLine="104"
summary="Show the current editor being used as a text string"
summaryComputed="true"
usage="contextShow"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcontextShow'$'\e''[0m'$'\n'''$'\n''Show the current editor being used as a text string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If no editor or running program can be determined'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mEDITOR'$'\e''[[(reset)]m - Used as a default editor (first)'$'\n''- '$'\e''[[(code)]mVISUAL'$'\e''[[(reset)]m - Used as another default editor (last)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: contextShow'$'\n'''$'\n''Show the current editor being used as a text string'$'\n'''$'\n''Return codes:'$'\n''- 1 - If no editor or running program can be determined'$'\n'''$'\n''Environment variables:'$'\n''- EDITOR - Used as a default editor (first)'$'\n''- VISUAL - Used as another default editor (last)'$'\n'''
documentationPath="documentation/source/tools/vendor.md"
