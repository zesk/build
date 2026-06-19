#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--target reportFile - File. Optional. Write coverage data to this file.\nthingToRun - Callable. Required. Function to run and collect coverage data.\n'
base="coverage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Collect code coverage statistics for a code sample\nConvert resulting files using `bashCoverageReport`\n\n'
descriptionLineCount="3"
file="bin/build/tools/coverage.sh"
fn="bashCoverage"
fnMarker="bashcoverage"
foundNames=([0]="argument" [1]="see")
line="15"
rawComment=$'Argument: --target reportFile - File. Optional. Write coverage data to this file.\nArgument: thingToRun - Callable. Required. Function to run and collect coverage data.\nCollect code coverage statistics for a code sample\nConvert resulting files using `bashCoverageReport`\nSee: bashCoverageReport\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'bashCoverageReport\n'
sourceFile="bin/build/tools/coverage.sh"
sourceHash="942def75e2c55f10f5a8c1d72625773f1a3e4dd1"
sourceLine="15"
summary="Collect code coverage statistics for a code sample"
summaryComputed="true"
usage="bashCoverage [ --target reportFile ] thingToRun"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCoverage'$'\e''[0m '$'\e''[[(blue)]m[ --target reportFile ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mthingToRun'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--target reportFile  '$'\e''[[(value)]mFile. Optional. Write coverage data to this file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mthingToRun           '$'\e''[[(value)]mCallable. Required. Function to run and collect coverage data.'$'\e''[[(reset)]m'$'\n'''$'\n''Collect code coverage statistics for a code sample'$'\n''Convert resulting files using '$'\e''[[(code)]mbashCoverageReport'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashCoverage [ --target reportFile ] thingToRun'$'\n'''$'\n''    --target reportFile  File. Optional. Write coverage data to this file.'$'\n''    thingToRun           Callable. Required. Function to run and collect coverage data.'$'\n'''$'\n''Collect code coverage statistics for a code sample'$'\n''Convert resulting files using bashCoverageReport'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/coverage.md"
