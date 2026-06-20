#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="templatePath - Directory. Required. Path to the templates to repair."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Map template files using our identical functionality"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationIdenticalRepair"
fnMarker="documentationidenticalrepair"
foundNames=([0]="argument")
line="238"
original="documentationIdenticalRepair"
rawComment="Map template files using our identical functionality"$'\n'"Argument: templatePath - Directory. Required. Path to the templates to repair."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="f2669a68b4e993cf819200b03f0975ce382e64b6"
sourceLine="238"
summary="Map template files using our identical functionality"
summaryComputed="true"
usage="documentationIdenticalRepair templatePath [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationIdenticalRepair'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtemplatePath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtemplatePath  '$'\e''[[(value)]mDirectory. Required. Path to the templates to repair.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Map template files using our identical functionality'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationIdenticalRepair templatePath [ --help ]'$'\n'''$'\n''    templatePath  Directory. Required. Path to the templates to repair.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Map template files using our identical functionality'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
