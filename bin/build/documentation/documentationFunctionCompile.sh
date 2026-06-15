#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--force - Flag. Optional. Create files regardless of cache status.\n--clean - Flag. Optional. Clean everything and then exit.\n--source codeSource - Directory. Required. Code source to find functions.\n--documentation documentationSource - Directory. Documentation source to find documentation links.\n--all - Flag. Optional. Check all functions.\n--fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.\nfunctionName ... - String. Optional. Specific functions to compile.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'- `--documentation` is required for `SEE:` files\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationFunctionCompile"
fnMarker="documentationfunctioncompile"
foundNames=([0]="argument" [1]="stdin")
line="544"
rawComment=$'- `--documentation` is required for `SEE:` files\nArgument: --force - Flag. Optional. Create files regardless of cache status.\nArgument: --clean - Flag. Optional. Clean everything and then exit.\nArgument: --source codeSource - Directory. Required. Code source to find functions.\nArgument: --documentation documentationSource - Directory. Documentation source to find documentation links.\nArgument: --all - Flag. Optional. Check all functions.\nArgument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.\nArgument: functionName ... - String. Optional. Specific functions to compile.\nstdin: functionName - File with function names one per line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="38500aa3e5be0ae446052278e0b3ea877261e5a8"
sourceLine="544"
stdin=$'functionName - File with function names one per line.\n'
summary="- \`--documentation\` is required for \`SEE:\` files"
summaryComputed="true"
usage="documentationFunctionCompile [ --force ] [ --clean ] --source codeSource [ --documentation documentationSource ] [ --all ] [ --fingerprint ] [ functionName ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationFunctionCompile'$'\e''[0m '$'\e''[[(blue)]m[ --force ]'$'\e''[0m '$'\e''[[(blue)]m[ --clean ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--source codeSource'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --documentation documentationSource ]'$'\e''[0m '$'\e''[[(blue)]m[ --all ]'$'\e''[0m '$'\e''[[(blue)]m[ --fingerprint ]'$'\e''[0m '$'\e''[[(blue)]m[ functionName ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--force                              '$'\e''[[(value)]mFlag. Optional. Create files regardless of cache status.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--clean                              '$'\e''[[(value)]mFlag. Optional. Clean everything and then exit.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--source codeSource                  '$'\e''[[(value)]mDirectory. Required. Code source to find functions.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--documentation documentationSource  '$'\e''[[(value)]mDirectory. Documentation source to find documentation links.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--all                                '$'\e''[[(value)]mFlag. Optional. Check all functions.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--fingerprint                        '$'\e''[[(value)]mFlag. Optional. Use fingerprint to ensure results are up to date.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfunctionName ...                     '$'\e''[[(value)]mString. Optional. Specific functions to compile.'$'\e''[[(reset)]m'$'\n'''$'\n''- '$'\e''[[(code)]m--documentation'$'\e''[[(reset)]m is required for '$'\e''[[(code)]mSEE:'$'\e''[[(reset)]m files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''functionName - File with function names one per line.'
# shellcheck disable=SC2016
helpPlain='Usage: documentationFunctionCompile [ --force ] [ --clean ] --source codeSource [ --documentation documentationSource ] [ --all ] [ --fingerprint ] [ functionName ... ]'$'\n'''$'\n''    --force                              Flag. Optional. Create files regardless of cache status.'$'\n''    --clean                              Flag. Optional. Clean everything and then exit.'$'\n''    --source codeSource                  Directory. Required. Code source to find functions.'$'\n''    --documentation documentationSource  Directory. Documentation source to find documentation links.'$'\n''    --all                                Flag. Optional. Check all functions.'$'\n''    --fingerprint                        Flag. Optional. Use fingerprint to ensure results are up to date.'$'\n''    functionName ...                     String. Optional. Specific functions to compile.'$'\n'''$'\n''- --documentation is required for SEE: files'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''functionName - File with function names one per line.'
documentationPath="documentation/source/tools/internal.md"
