#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
##
##
argument=$'--settings - Flag. Optional. `matchText` is a function name. Outputs a file name containing function settings\n--comment - Flag. Optional. `matchText` is a function name. Outputs a file name containing function settings\n--source - Flag. Optional. `matchText` is a function name. Outputs the source code path to where the function is defined\n--line - Flag. Optional. `matchText` is a function name. Outputs the source code line where the function is defined\n--combined - Flag. Optional. `matchText` is a function name. Outputs the source code path and line where the function is defined as `path:line`\n--file - Flag. Optional. `matchText` is a file name. Find files which match this base file name.\nmatchText - String. Token to look up in the index.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Looks up information in the function index\n##\n\n'
descriptionLineCount="3"
file="bin/build/tools/documentation.sh"
fn="documentationIndexLookup"
fnMarker="documentationindexlookup"
foundNames=([0]="argument")
line="317"
rawComment=$'Looks up information in the function index\n##\nArgument: --settings - Flag. Optional. `matchText` is a function name. Outputs a file name containing function settings\nArgument: --comment - Flag. Optional. `matchText` is a function name. Outputs a file name containing function settings\nArgument: --source - Flag. Optional. `matchText` is a function name. Outputs the source code path to where the function is defined\nArgument: --line - Flag. Optional. `matchText` is a function name. Outputs the source code line where the function is defined\nArgument: --combined - Flag. Optional. `matchText` is a function name. Outputs the source code path and line where the function is defined as `path:line`\nArgument: --file - Flag. Optional. `matchText` is a file name. Find files which match this base file name.\nArgument: matchText - String. Token to look up in the index.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="0134555ea1c32d02fdc40fd9058827a280501390"
sourceLine="317"
summary="Looks up information in the function index"
summaryComputed="true"
usage="documentationIndexLookup [ --settings ] [ --comment ] [ --source ] [ --line ] [ --combined ] [ --file ] [ matchText ]"
