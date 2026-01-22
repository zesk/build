#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/coverage.sh"
argument="--cache cacheDirectory - Optional. Directory."$'\n'"--target targetDirectory - Optional. Directory."$'\n'"statsFile - File. Required."$'\n'""
base="coverage.sh"
description="Generate a coverage report using the coverage statistics file"$'\n'""$'\n'"*This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*"$'\n'""
file="bin/build/tools/coverage.sh"
fn="bashCoverageReport"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/coverage.sh"
sourceModified="1768513812"
stdin="Accepts a stats file"$'\n'""
summary="Experimental. Likely abandon."$'\n'""
usage="bashCoverageReport [ --cache cacheDirectory ] [ --target targetDirectory ] statsFile"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashCoverageReport[0m [94m[ --cache cacheDirectory ][0m [94m[ --target targetDirectory ][0m [38;2;255;255;0m[35;48;2;0;0;0mstatsFile[0m[0m

    [94m--cache cacheDirectory    [1;97mOptional. Directory.[0m
    [94m--target targetDirectory  [1;97mOptional. Directory.[0m
    [31mstatsFile                 [1;97mFile. Required.[0m

Generate a coverage report using the coverage statistics file

[36mThis is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Accepts a stats file
'
# shellcheck disable=SC2016
helpPlain='Usage: bashCoverageReport [ --cache cacheDirectory ] [ --target targetDirectory ] statsFile

    --cache cacheDirectory    Optional. Directory.
    --target targetDirectory  Optional. Directory.
    statsFile                 File. Required.

Generate a coverage report using the coverage statistics file

This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Accepts a stats file
'
