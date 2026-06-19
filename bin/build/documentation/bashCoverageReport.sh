#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--cache cacheDirectory - Optional. Directory.\n--target targetDirectory - Optional. Directory.\nstatsFile - File. Required.\n'
base="coverage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate a coverage report using the coverage statistics file\n\n*This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*\n\n'
descriptionLineCount="4"
file="bin/build/tools/coverage.sh"
fn="bashCoverageReport"
fnMarker="bashcoveragereport"
foundNames=([0]="summary" [1]="argument" [2]="stdin")
line="58"
rawComment=$'Generate a coverage report using the coverage statistics file\n*This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*\nSummary: Experimental. Likely abandon.\nArgument: --cache cacheDirectory - Optional. Directory.\nArgument: --target targetDirectory - Optional. Directory.\nArgument: statsFile - File. Required.\nstdin: Accepts a stats file\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/coverage.sh"
sourceHash="942def75e2c55f10f5a8c1d72625773f1a3e4dd1"
sourceLine="58"
stdin=$'Accepts a stats file\n'
summary="Experimental. Likely abandon."
summaryComputed=""
usage="bashCoverageReport [ --cache cacheDirectory ] [ --target targetDirectory ] statsFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCoverageReport'$'\e''[0m '$'\e''[[(blue)]m[ --cache cacheDirectory ]'$'\e''[0m '$'\e''[[(blue)]m[ --target targetDirectory ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstatsFile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--cache cacheDirectory    '$'\e''[[(value)]mOptional. Directory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--target targetDirectory  '$'\e''[[(value)]mOptional. Directory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mstatsFile                 '$'\e''[[(value)]mFile. Required.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate a coverage report using the coverage statistics file'$'\n'''$'\n'''$'\e''[[(cyan)]mThis is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Accepts a stats file'
# shellcheck disable=SC2016
helpPlain='Usage: bashCoverageReport [ --cache cacheDirectory ] [ --target targetDirectory ] statsFile'$'\n'''$'\n''    --cache cacheDirectory    Optional. Directory.'$'\n''    --target targetDirectory  Optional. Directory.'$'\n''    statsFile                 File. Required.'$'\n'''$'\n''Generate a coverage report using the coverage statistics file'$'\n'''$'\n''This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Accepts a stats file'
documentationPath="documentation/source/tools/coverage.md"
