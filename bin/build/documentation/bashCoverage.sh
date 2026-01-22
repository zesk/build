#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/coverage.sh"
argument="--target reportFile - File. Optional. Write coverage data to this file."$'\n'"thingToRun - Callable. Required. Function to run and collect coverage data."$'\n'""
base="coverage.sh"
description="Collect code coverage statistics for a code sample"$'\n'"Convert resulting files using \`bashCoverageReport\`"$'\n'""
file="bin/build/tools/coverage.sh"
fn="bashCoverage"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashCoverageReport"$'\n'""
sourceFile="bin/build/tools/coverage.sh"
sourceModified="1768513812"
summary="Collect code coverage statistics for a code sample"
usage="bashCoverage [ --target reportFile ] thingToRun"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashCoverage[0m [94m[ --target reportFile ][0m [38;2;255;255;0m[35;48;2;0;0;0mthingToRun[0m[0m

    [94m--target reportFile  [1;97mFile. Optional. Write coverage data to this file.[0m
    [31mthingToRun           [1;97mCallable. Required. Function to run and collect coverage data.[0m

Collect code coverage statistics for a code sample
Convert resulting files using [38;2;0;255;0;48;2;0;0;0mbashCoverageReport[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashCoverage [ --target reportFile ] thingToRun

    --target reportFile  File. Optional. Write coverage data to this file.
    thingToRun           Callable. Required. Function to run and collect coverage data.

Collect code coverage statistics for a code sample
Convert resulting files using bashCoverageReport

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
