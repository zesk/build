#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--cache cacheDirectory - Optional. Directory."$'\n'"--target targetDirectory - Optional. Directory."$'\n'"statsFile - File. Required."$'\n'""
base="coverage.sh"
description="Generate a coverage report using the coverage statistics file"$'\n'"*This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*"$'\n'""
file="bin/build/tools/coverage.sh"
fn="bashCoverageReport"
foundNames=([0]="summary" [1]="argument" [2]="stdin")
rawComment="Generate a coverage report using the coverage statistics file"$'\n'"*This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*"$'\n'"Summary: Experimental. Likely abandon."$'\n'"Argument: --cache cacheDirectory - Optional. Directory."$'\n'"Argument: --target targetDirectory - Optional. Directory."$'\n'"Argument: statsFile - File. Required."$'\n'"stdin: Accepts a stats file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/coverage.sh"
sourceHash="708145e45bbfcfcf14039e6b317f15c5bd01ee35"
stdin="Accepts a stats file"$'\n'""
summary="Experimental. Likely abandon."$'\n'""
usage="bashCoverageReport [ --cache cacheDirectory ] [ --target targetDirectory ] statsFile"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
