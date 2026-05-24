#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--clean - Flag. Optional. Clean everything and then exit.\n--git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)\n--all - Flag. Optional. Do everything regardless of cache state.\n--derive command ... -- - CommandList. Optional. Run this command on each changed settings file to generate derived files.\nfunctionName ... - String. Optional. Specific functions to compile.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Extract and build the documentation settings cache\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationFileCompile"
fnMarker="documentationfilecompile"
foundNames=([0]="argument" [1]="stdin")
line="552"
rawComment=$'Extract and build the documentation settings cache\nArgument: --clean - Flag. Optional. Clean everything and then exit.\nArgument: --git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)\nArgument: --all - Flag. Optional. Do everything regardless of cache state.\nArgument: --derive command ... -- - CommandList. Optional. Run this command on each changed settings file to generate derived files.\nArgument: functionName ... - String. Optional. Specific functions to compile.\nArgument: --help - Flag. Optional. Display this help.\nstdin: functionName - File with function names one per line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fa382137d00499e888f4c9bf0ffc9e1256277eb1"
sourceLine="552"
stdin=$'functionName - File with function names one per line.\n'
summary="Extract and build the documentation settings cache"
summaryComputed="true"
usage="documentationFileCompile [ --clean ] [ --git ] [ --all ] [ --derive command ... -- ] [ functionName ... ] [ --help ]"
