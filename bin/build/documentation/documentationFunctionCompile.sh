#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--clean - Flag. Optional. Clean everything and then exit.\n--git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)\n--all - Flag. Optional. Do everything regardless of cache state.\n--fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.\nfunctionName ... - String. Optional. Specific functions to compile.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Extract and build the documentation settings cache and generate derived files\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationFunctionCompile"
fnMarker="documentationfunctioncompile"
foundNames=([0]="argument" [1]="stdin")
line="458"
rawComment=$'Extract and build the documentation settings cache and generate derived files\nArgument: --clean - Flag. Optional. Clean everything and then exit.\nArgument: --git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)\nArgument: --all - Flag. Optional. Do everything regardless of cache state.\nArgument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.\nArgument: functionName ... - String. Optional. Specific functions to compile.\nstdin: functionName - File with function names one per line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="adaaf07fae6ca75e42010abe334da1e6b472b583"
sourceLine="458"
stdin=$'functionName - File with function names one per line.\n'
summary="Extract and build the documentation settings cache and generate derived"
summaryComputed="true"
usage="documentationFunctionCompile [ --clean ] [ --git ] [ --all ] [ --fingerprint ] [ functionName ... ]"
