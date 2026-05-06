#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--target reportFile - File. Optional. Write coverage data to this file."$'\n'"thingToRun - Callable. Required. Function to run and collect coverage data."$'\n'""
base="coverage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Collect code coverage statistics for a code sample"$'\n'"Convert resulting files using \`bashCoverageReport\`"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/coverage.sh"
fn="bashCoverage"
fnMarker="bashcoverage"
foundNames=([0]="argument" [1]="see")
line="15"
rawComment="Argument: --target reportFile - File. Optional. Write coverage data to this file."$'\n'"Argument: thingToRun - Callable. Required. Function to run and collect coverage data."$'\n'"Collect code coverage statistics for a code sample"$'\n'"Convert resulting files using \`bashCoverageReport\`"$'\n'"See: bashCoverageReport"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashCoverageReport"$'\n'""
sourceFile="bin/build/tools/coverage.sh"
sourceHash="ed68c68efac83cfc1df20c08d84b78a022c7d400"
sourceLine="15"
summary="Collect code coverage statistics for a code sample"
summaryComputed="true"
usage="bashCoverage [ --target reportFile ] thingToRun"
