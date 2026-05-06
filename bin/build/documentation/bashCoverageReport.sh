#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--cache cacheDirectory - Optional. Directory."$'\n'"--target targetDirectory - Optional. Directory."$'\n'"statsFile - File. Required."$'\n'""
base="coverage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generate a coverage report using the coverage statistics file"$'\n'""$'\n'"*This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/coverage.sh"
fn="bashCoverageReport"
fnMarker="bashcoveragereport"
foundNames=([0]="summary" [1]="argument" [2]="stdin")
line="58"
rawComment="Generate a coverage report using the coverage statistics file"$'\n'"*This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*"$'\n'"Summary: Experimental. Likely abandon."$'\n'"Argument: --cache cacheDirectory - Optional. Directory."$'\n'"Argument: --target targetDirectory - Optional. Directory."$'\n'"Argument: statsFile - File. Required."$'\n'"stdin: Accepts a stats file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/coverage.sh"
sourceHash="ed68c68efac83cfc1df20c08d84b78a022c7d400"
sourceLine="58"
stdin="Accepts a stats file"$'\n'""
summary="Experimental. Likely abandon."
summaryComputed=""
usage="bashCoverageReport [ --cache cacheDirectory ] [ --target targetDirectory ] statsFile"
