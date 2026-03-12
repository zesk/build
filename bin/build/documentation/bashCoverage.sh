#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--target reportFile - File. Optional. Write coverage data to this file."$'\n'"thingToRun - Callable. Required. Function to run and collect coverage data."$'\n'""
base="coverage.sh"
description="Collect code coverage statistics for a code sample"$'\n'"Convert resulting files using \`bashCoverageReport\`"$'\n'""
file="bin/build/tools/coverage.sh"
fn="bashCoverage"
foundNames=([0]="argument" [1]="see")
rawComment="Argument: --target reportFile - File. Optional. Write coverage data to this file."$'\n'"Argument: thingToRun - Callable. Required. Function to run and collect coverage data."$'\n'"Collect code coverage statistics for a code sample"$'\n'"Convert resulting files using \`bashCoverageReport\`"$'\n'"See: bashCoverageReport"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashCoverageReport"$'\n'""
sourceFile="bin/build/tools/coverage.sh"
sourceHash="708145e45bbfcfcf14039e6b317f15c5bd01ee35"
summary="Collect code coverage statistics for a code sample"
summaryComputed="true"
usage="bashCoverage [ --target reportFile ] thingToRun"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
