#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'templatePath - Directory. Required. Path to the templates to repair.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Map template files using our identical functionality\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationIdenticalRepair"
fnMarker="documentationidenticalrepair"
foundNames=([0]="argument")
line="236"
rawComment=$'Map template files using our identical functionality\nArgument: templatePath - Directory. Required. Path to the templates to repair.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="38500aa3e5be0ae446052278e0b3ea877261e5a8"
sourceLine="236"
summary="Map template files using our identical functionality"
summaryComputed="true"
usage="documentationIdenticalRepair templatePath [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationIdenticalRepair'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtemplatePath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtemplatePath  '$'\e''[[(value)]mDirectory. Required. Path to the templates to repair.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Map template files using our identical functionality'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationIdenticalRepair templatePath [ --help ]'$'\n'''$'\n''    templatePath  Directory. Required. Path to the templates to repair.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Map template files using our identical functionality'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
