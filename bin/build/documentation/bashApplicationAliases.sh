#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Reads from `stdin` lines which is broken into three tokens by spaces:\n    alias pathName projectName\nThe directories which exist at $HOME/$pathName will have aliases created for the project in Bash:\n- `g-alias` - Change directory to this project (temporary)\n- `G-alias` - Change directory and set application home to this project (survives logout)\nThe `projectName` is optional as it is extracted from the target project using the `APPLICATION_NAME`.\n\n'
descriptionLineCount="7"
environment=$'APPLICATION_NAME\n'
file="bin/build/tools/bash.sh"
fn="bashApplicationAliases"
fnMarker="bashapplicationaliases"
foundNames=([0]="summary" [1]="stdin" [2]="environment" [3]="argument")
line="693"
original="bashApplicationAliases"
rawComment=$'Summary: Create aliases for projects\nstdin: String Directory String:line\nReads from `stdin` lines which is broken into three tokens by spaces:\n    alias pathName projectName\nThe directories which exist at $HOME/$pathName will have aliases created for the project in Bash:\n- `g-alias` - Change directory to this project (temporary)\n- `G-alias` - Change directory and set application home to this project (survives logout)\nThe `projectName` is optional as it is extracted from the target project using the `APPLICATION_NAME`.\nEnvironment: APPLICATION_NAME\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="9822477a1f3a6f53599f6f26b9aa3886ba4c5595"
sourceLine="693"
stdin=$'String Directory String:line\n'
summary="Create aliases for projects"
summaryComputed=""
usage="bashApplicationAliases [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashApplicationAliases'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m lines which is broken into three tokens by spaces:'$'\n''    alias pathName projectName'$'\n''The directories which exist at $HOME/$pathName will have aliases created for the project in Bash:'$'\n''- '$'\e''[[(code)]mg-alias'$'\e''[[(reset)]m - Change directory to this project (temporary)'$'\n''- '$'\e''[[(code)]mG-alias'$'\e''[[(reset)]m - Change directory and set application home to this project (survives logout)'$'\n''The '$'\e''[[(code)]mprojectName'$'\e''[[(reset)]m is optional as it is extracted from the target project using the '$'\e''[[(code)]mAPPLICATION_NAME'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- APPLICATION_NAME'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''String Directory String:line'
# shellcheck disable=SC2016
helpPlain='Usage: bashApplicationAliases [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Reads from stdin lines which is broken into three tokens by spaces:'$'\n''    alias pathName projectName'$'\n''The directories which exist at $HOME/$pathName will have aliases created for the project in Bash:'$'\n''- g-alias - Change directory to this project (temporary)'$'\n''- G-alias - Change directory and set application home to this project (survives logout)'$'\n''The projectName is optional as it is extracted from the target project using the APPLICATION_NAME.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- APPLICATION_NAME'$'\n'''$'\n''Reads from stdin:'$'\n''String Directory String:line'
documentationPath=""
