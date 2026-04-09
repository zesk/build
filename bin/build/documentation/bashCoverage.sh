#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--target reportFile - File. Optional. Write coverage data to this file."$'\n'"thingToRun - Callable. Required. Function to run and collect coverage data."$'\n'""
base="coverage.sh"
description="Collect code coverage statistics for a code sample"$'\n'"Convert resulting files using \`bashCoverageReport\`"$'\n'""
file="bin/build/tools/coverage.sh"
fn="bashCoverage"
foundNames=([0]="argument" [1]="see")
line="15"
lowerFn="bashcoverage"
rawComment="Argument: --target reportFile - File. Optional. Write coverage data to this file."$'\n'"Argument: thingToRun - Callable. Required. Function to run and collect coverage data."$'\n'"Collect code coverage statistics for a code sample"$'\n'"Convert resulting files using \`bashCoverageReport\`"$'\n'"See: bashCoverageReport"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashCoverageReport"$'\n'""
sourceFile="bin/build/tools/coverage.sh"
sourceHash="ed68c68efac83cfc1df20c08d84b78a022c7d400"
sourceLine="15"
summary="Collect code coverage statistics for a code sample"
summaryComputed="true"
usage="bashCoverage [ --target reportFile ] thingToRun"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCoverage'$'\e''[0m '$'\e''[[(blue)]m[ --target reportFile ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mthingToRun'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--target reportFile  '$'\e''[[(value)]mFile. Optional. Write coverage data to this file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mthingToRun           '$'\e''[[(value)]mCallable. Required. Function to run and collect coverage data.'$'\e''[[(reset)]m'$'\n'''$'\n''Collect code coverage statistics for a code sample'$'\n''Convert resulting files using '$'\e''[[(code)]mbashCoverageReport'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashCoverage [ --target reportFile ] thingToRun'$'\n'''$'\n''    --target reportFile  File. Optional. Write coverage data to this file.'$'\n''    thingToRun           Callable. Required. Function to run and collect coverage data.'$'\n'''$'\n''Collect code coverage statistics for a code sample'$'\n''Convert resulting files using bashCoverageReport'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/coverage.md"
