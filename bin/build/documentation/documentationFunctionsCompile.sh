#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-11
# shellcheck disable=SC2034
argument="--clean - Flag. Optional. Clean everything and then exit."$'\n'"--all - Flag. Optional. Do everything regardless of cache state."$'\n'"--fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date."$'\n'"--source - Directory. Required. Directory where functions are defined."$'\n'"--key fingerprintKey - String. Optional. Use this name to cache results in application JSON file if available."$'\n'"functionName ... - String. Optional. Specific functions to compile."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extract and build the documentation settings cache and generate derived files"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationFunctionsCompile"
fnMarker="documentationfunctionscompile"
foundNames=([0]="argument" [1]="stdin")
line="470"
rawComment="Extract and build the documentation settings cache and generate derived files"$'\n'"Argument: --clean - Flag. Optional. Clean everything and then exit."$'\n'"Argument: --all - Flag. Optional. Do everything regardless of cache state."$'\n'"Argument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date."$'\n'"Argument: --source - Directory. Required. Directory where functions are defined."$'\n'"Argument: --key fingerprintKey - String. Optional. Use this name to cache results in application JSON file if available."$'\n'"Argument: functionName ... - String. Optional. Specific functions to compile."$'\n'"stdin: Function. Name of functions, one per line to compile if \`--all\` is not specified."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="27710a9141283b9bb677e2d559eed326e8761d6f"
sourceLine="470"
stdin="Function. Name of functions, one per line to compile if \`--all\` is not specified."$'\n'""
summary="Extract and build the documentation settings cache and generate derived"
summaryComputed="true"
usage="documentationFunctionsCompile [ --clean ] [ --all ] [ --fingerprint ] --source [ --key fingerprintKey ] [ functionName ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationFunctionsCompile'$'\e''[0m '$'\e''[[(blue)]m[ --clean ]'$'\e''[0m '$'\e''[[(blue)]m[ --all ]'$'\e''[0m '$'\e''[[(blue)]m[ --fingerprint ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--source'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --key fingerprintKey ]'$'\e''[0m '$'\e''[[(blue)]m[ functionName ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--clean               '$'\e''[[(value)]mFlag. Optional. Clean everything and then exit.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--all                 '$'\e''[[(value)]mFlag. Optional. Do everything regardless of cache state.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--fingerprint         '$'\e''[[(value)]mFlag. Optional. Use fingerprint to ensure results are up to date.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--source              '$'\e''[[(value)]mDirectory. Required. Directory where functions are defined.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--key fingerprintKey  '$'\e''[[(value)]mString. Optional. Use this name to cache results in application JSON file if available.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfunctionName ...      '$'\e''[[(value)]mString. Optional. Specific functions to compile.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract and build the documentation settings cache and generate derived files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Function. Name of functions, one per line to compile if '$'\e''[[(code)]m--all'$'\e''[[(reset)]m is not specified.'
# shellcheck disable=SC2016
helpPlain='Usage: documentationFunctionsCompile [ --clean ] [ --all ] [ --fingerprint ] --source [ --key fingerprintKey ] [ functionName ... ]'$'\n'''$'\n''    --clean               Flag. Optional. Clean everything and then exit.'$'\n''    --all                 Flag. Optional. Do everything regardless of cache state.'$'\n''    --fingerprint         Flag. Optional. Use fingerprint to ensure results are up to date.'$'\n''    --source              Directory. Required. Directory where functions are defined.'$'\n''    --key fingerprintKey  String. Optional. Use this name to cache results in application JSON file if available.'$'\n''    functionName ...      String. Optional. Specific functions to compile.'$'\n'''$'\n''Extract and build the documentation settings cache and generate derived files'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Function. Name of functions, one per line to compile if --all is not specified.'
documentationPath="documentation/source/tools/documentation.md"
