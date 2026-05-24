#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
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
sourceHash="722f16e9f75d68a68128649b36bf97f3eec00345"
sourceLine="15"
summary="Collect code coverage statistics for a code sample"
summaryComputed="true"
usage="bashCoverage [ --target reportFile ] thingToRun"
