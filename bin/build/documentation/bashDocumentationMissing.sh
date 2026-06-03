#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-03
# shellcheck disable=SC2034
argument=$'--index indexPath - Directory. Required. Where to store documentation indexes for later use.\n--source sourcePath - Directory. Required. The source\n--target templateTarget - FileDirectory. Required. Create templates here.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generates:\n- `missingFunctionTotal.md`\n- `missingFunctionList.md`\nin the target directory.\n\n'
descriptionLineCount="5"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationMissing"
fnMarker="bashdocumentationmissing"
foundNames=([0]="summary" [1]="argument")
line="756"
rawComment=$'Summary: Generate templates of functions missing from documentation\nGenerates:\n- `missingFunctionTotal.md`\n- `missingFunctionList.md`\nin the target directory.\nArgument: --index indexPath - Directory. Required. Where to store documentation indexes for later use.\nArgument: --source sourcePath - Directory. Required. The source\nArgument: --target templateTarget - FileDirectory. Required. Create templates here.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="a3794434b7e4d336ccd6c9cbf964150d59b552f0"
sourceLine="756"
summary="Generate templates of functions missing from documentation"
summaryComputed=""
usage="bashDocumentationMissing --index indexPath --source sourcePath --target templateTarget"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDocumentationMissing'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--index indexPath'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--source sourcePath'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--target templateTarget'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m--index indexPath        '$'\e''[[(value)]mDirectory. Required. Where to store documentation indexes for later use.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--source sourcePath      '$'\e''[[(value)]mDirectory. Required. The source'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--target templateTarget  '$'\e''[[(value)]mFileDirectory. Required. Create templates here.'$'\e''[[(reset)]m'$'\n'''$'\n''Generates:'$'\n''- '$'\e''[[(code)]mmissingFunctionTotal.md'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mmissingFunctionList.md'$'\e''[[(reset)]m'$'\n''in the target directory.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashDocumentationMissing --index indexPath --source sourcePath --target templateTarget'$'\n'''$'\n''    --index indexPath        Directory. Required. Where to store documentation indexes for later use.'$'\n''    --source sourcePath      Directory. Required. The source'$'\n''    --target templateTarget  FileDirectory. Required. Create templates here.'$'\n'''$'\n''Generates:'$'\n''- missingFunctionTotal.md'$'\n''- missingFunctionList.md'$'\n''in the target directory.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
