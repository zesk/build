#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'environmentFile - EnvironmentFile. Required. File to convert to a settings file.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Convert an environment comment to environment variables"
descriptionLineCount=""
file="bin/build/tools/documentation.sh"
fn="documentationEnvironmentFileParse"
fnMarker="documentationenvironmentfileparse"
foundNames=([0]="summary" [1]="argument")
line="202"
original="documentationEnvironmentFileParse"
rawComment=$'Summary: Convert an environment comment to environment variables\nArgument: environmentFile - EnvironmentFile. Required. File to convert to a settings file.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="d51e4672057607172307c44e6065c356ed05ce35"
sourceLine="202"
summary="Convert an environment comment to environment variables"
summaryComputed=""
usage="documentationEnvironmentFileParse environmentFile [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationEnvironmentFileParse'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]menvironmentFile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]menvironmentFile  '$'\e''[[(value)]mEnvironmentFile. Required. File to convert to a settings file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help           '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Convert an environment comment to environment variables'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationEnvironmentFileParse environmentFile [ --help ]'$'\n'''$'\n''    environmentFile  EnvironmentFile. Required. File to convert to a settings file.'$'\n''    --help           Flag. Optional. Display this help.'$'\n'''$'\n''Convert an environment comment to environment variables'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
