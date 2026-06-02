#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-02
# shellcheck disable=SC2034
argument=$'--clean - Flag. Optional. Clean everything and then exit.\n--git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)\n--all - Flag. Optional. Do everything regardless of cache state.\n--source sourcePath - Directory. Required. Find function source code definition in this directory.\n--derive command ... -- - CommandList. Optional. Run this command on each changed settings file to generate derived files.\nfunctionName ... - String. Optional. Specific functions to compile.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Extract and build the documentation settings cache\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationFileCompile"
fnMarker="documentationfilecompile"
foundNames=([0]="argument" [1]="stdin")
line="640"
rawComment=$'Extract and build the documentation settings cache\nArgument: --clean - Flag. Optional. Clean everything and then exit.\nArgument: --git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)\nArgument: --all - Flag. Optional. Do everything regardless of cache state.\nArgument: --source sourcePath - Directory. Required. Find function source code definition in this directory.\nArgument: --derive command ... -- - CommandList. Optional. Run this command on each changed settings file to generate derived files.\nArgument: functionName ... - String. Optional. Specific functions to compile.\nArgument: --help - Flag. Optional. Display this help.\nstdin: functionName - File with function names one per line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fe683a0979555e5011a73b30a3317e59cea3b184"
sourceLine="640"
stdin=$'functionName - File with function names one per line.\n'
summary="Extract and build the documentation settings cache"
summaryComputed="true"
usage="documentationFileCompile [ --clean ] [ --git ] [ --all ] --source sourcePath [ --derive command ... -- ] [ functionName ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationFileCompile'$'\e''[0m '$'\e''[[(blue)]m[ --clean ]'$'\e''[0m '$'\e''[[(blue)]m[ --git ]'$'\e''[0m '$'\e''[[(blue)]m[ --all ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--source sourcePath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --derive command ... -- ]'$'\e''[0m '$'\e''[[(blue)]m[ functionName ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--clean                  '$'\e''[[(value)]mFlag. Optional. Clean everything and then exit.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--git                    '$'\e''[[(value)]mFlag. Optional. Do some handy '$'\e''[[(code)]mgit'$'\e''[[(reset)]m changes. (Adding/removing files)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--all                    '$'\e''[[(value)]mFlag. Optional. Do everything regardless of cache state.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--source sourcePath      '$'\e''[[(value)]mDirectory. Required. Find function source code definition in this directory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--derive command ... --  '$'\e''[[(value)]mCommandList. Optional. Run this command on each changed settings file to generate derived files.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfunctionName ...         '$'\e''[[(value)]mString. Optional. Specific functions to compile.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract and build the documentation settings cache'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''functionName - File with function names one per line.'
# shellcheck disable=SC2016
helpPlain='Usage: documentationFileCompile [ --clean ] [ --git ] [ --all ] --source sourcePath [ --derive command ... -- ] [ functionName ... ] [ --help ]'$'\n'''$'\n''    --clean                  Flag. Optional. Clean everything and then exit.'$'\n''    --git                    Flag. Optional. Do some handy git changes. (Adding/removing files)'$'\n''    --all                    Flag. Optional. Do everything regardless of cache state.'$'\n''    --source sourcePath      Directory. Required. Find function source code definition in this directory.'$'\n''    --derive command ... --  CommandList. Optional. Run this command on each changed settings file to generate derived files.'$'\n''    functionName ...         String. Optional. Specific functions to compile.'$'\n''    --help                   Flag. Optional. Display this help.'$'\n'''$'\n''Extract and build the documentation settings cache'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''functionName - File with function names one per line.'
documentationPath="documentation/source/tools/internal.md"
