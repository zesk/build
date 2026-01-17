#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/coverage.sh"
argument="--target reportFile - File. Optional. Write coverage data to this file."$'\n'"thingToRun - Callable. Required. Function to run and collect coverage data."$'\n'""
base="coverage.sh"
description="Collect code coverage statistics for a code sample"$'\n'"Convert resulting files using \`bashCoverageReport\`"$'\n'""
file="bin/build/tools/coverage.sh"
fn="bashCoverage"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""$'\n'""$'\n'""
see="bashCoverageReport"$'\n'""
source="bin/build/tools/coverage.sh"
sourceModified="1768513812"
summary="Collect code coverage statistics for a code sample"
usage="bashCoverage [ --target reportFile ] thingToRun"
