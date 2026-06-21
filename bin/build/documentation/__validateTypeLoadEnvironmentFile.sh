#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument=$'variableValue - String. Required.\n'
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Validates a value as an environment file which is loaded immediately.\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="__validateTypeLoadEnvironmentFile"
fnMarker="__validatetypeloadenvironmentfile"
foundNames=([0]="argument" [1]="return_code")
line="489"
original="__validateTypeLoadEnvironmentFile"
rawComment=$'Validates a value as an environment file which is loaded immediately.\nArgument: variableValue - String. Required.\nReturn Code: 2 - Argument error\nReturn Code: 0 - Success\n\n'
return_code=$'2 - Argument error\n0 - Success\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="4f8ffd4b24993e2c06fe909247c19c030b8e0214"
sourceLine="489"
summary="Validates a value as an environment file which is loaded"
summaryComputed="true"
usage="__validateTypeLoadEnvironmentFile variableValue"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeLoadEnvironmentFile'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvariableValue'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvariableValue  '$'\e''[[(value)]mString. Required.'$'\e''[[(reset)]m'$'\n'''$'\n''Validates a value as an environment file which is loaded immediately.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeLoadEnvironmentFile variableValue'$'\n'''$'\n''    variableValue  String. Required.'$'\n'''$'\n''Validates a value as an environment file which is loaded immediately.'$'\n'''$'\n''Return codes:'$'\n''- 2 - Argument error'$'\n''- 0 - Success'
documentationPath=""
