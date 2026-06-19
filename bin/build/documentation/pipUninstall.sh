#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\npipPackage [ ... ] - String. Required. Pip package name to uninstall.\n'
base="python.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Utility to uninstall python dependencies via pip\n\n'
descriptionLineCount="2"
file="bin/build/tools/python.sh"
fn="pipUninstall"
fnMarker="pipuninstall"
foundNames=([0]="argument")
line="137"
rawComment=$'Utility to uninstall python dependencies via pip\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: pipPackage [ ... ] - String. Required. Pip package name to uninstall.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/python.sh"
sourceHash="b7e7ea9a0cc8aa3547217b3f9a8d5f7ebe999fbd"
sourceLine="137"
summary="Utility to uninstall python dependencies via pip"
summaryComputed="true"
usage="pipUninstall [ --help ] [ --handler handler ] pipPackage [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpipUninstall'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpipPackage [ ... ]'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help              '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler   '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpipPackage [ ... ]  '$'\e''[[(value)]mString. Required. Pip package name to uninstall.'$'\e''[[(reset)]m'$'\n'''$'\n''Utility to uninstall python dependencies via pip'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: pipUninstall [ --help ] [ --handler handler ] pipPackage [ ... ]'$'\n'''$'\n''    --help              Flag. Optional. Display this help.'$'\n''    --handler handler   Function. Optional. Use this error handler instead of the default error handler.'$'\n''    pipPackage [ ... ]  String. Required. Pip package name to uninstall.'$'\n'''$'\n''Utility to uninstall python dependencies via pip'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/python.md"
