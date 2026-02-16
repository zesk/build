#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-16
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Show list of true results when all arguments pass."$'\n'"functionName ... - String. Function to look up to see if it has been tested. One or more."$'\n'""
base="test.sh"
description="No documentation for \`testSuiteFunctionTested\`."$'\n'""
file="bin/build/tools/test.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --verbose - Flag. Optional. Show list of true results when all arguments pass."$'\n'"Argument: functionName ... - String. Function to look up to see if it has been tested. One or more."$'\n'"Return Code: 0 - This function was tested by the test suite at least once."$'\n'"Return Code: 1 - Not tested"$'\n'""$'\n'""
return_code="0 - This function was tested by the test suite at least once."$'\n'"1 - Not tested"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="77b84e73e319fe65cb0a5e4a759e33d70fc9abda"
summary="undocumented"
usage="testSuiteFunctionTested [ --help ] [ --verbose ] [ functionName ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtestSuiteFunctionTested'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ functionName ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help            '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose         '$'\e''[[(value)]mFlag. Optional. Show list of true results when all arguments pass.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfunctionName ...  '$'\e''[[(value)]mString. Function to look up to see if it has been tested. One or more.'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]mtestSuiteFunctionTested'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - This function was tested by the test suite at least once.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Not tested'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: testSuiteFunctionTested [ --help ] [ --verbose ] [ functionName ... ]'$'\n'''$'\n''    --help            Flag. Optional. Display this help.'$'\n''    --verbose         Flag. Optional. Show list of true results when all arguments pass.'$'\n''    functionName ...  String. Function to look up to see if it has been tested. One or more.'$'\n'''$'\n''No documentation for testSuiteFunctionTested.'$'\n'''$'\n''Return codes:'$'\n''- 0 - This function was tested by the test suite at least once.'$'\n''- 1 - Not tested'$'\n'''
