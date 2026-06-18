#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--check - Flag. Optional. Check to see if an update is needed\nsettingsFile - File. Required. Settings file for function to document.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate function derived files.\n\nFile(s) are generated next to `settingsFile`.\n\n- `--check` checks to see if the file needs to be generated or updated. Returns 0 if up to date.\n\n'
descriptionLineCount="6"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationDeriveFunction"
fnMarker="bashdocumentationderivefunction"
foundNames=([0]="summary" [1]="argument")
line="835"
rawComment=$'Summary: Generate markdown documentation page\nGenerate function derived files.\nFile(s) are generated next to `settingsFile`.\n- `--check` checks to see if the file needs to be generated or updated. Returns 0 if up to date.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --check - Flag. Optional. Check to see if an update is needed\nArgument: settingsFile - File. Required. Settings file for function to document.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="a8ddc3085c0bd75f808305b573edf755e62ddc0b"
sourceLine="835"
summary="Generate markdown documentation page"
summaryComputed=""
usage="bashDocumentationDeriveFunction [ --help ] [ --check ] settingsFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDocumentationDeriveFunction'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --check ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msettingsFile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--check       '$'\e''[[(value)]mFlag. Optional. Check to see if an update is needed'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msettingsFile  '$'\e''[[(value)]mFile. Required. Settings file for function to document.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate function derived files.'$'\n'''$'\n''File(s) are generated next to '$'\e''[[(code)]msettingsFile'$'\e''[[(reset)]m.'$'\n'''$'\n''- '$'\e''[[(code)]m--check'$'\e''[[(reset)]m checks to see if the file needs to be generated or updated. Returns 0 if up to date.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashDocumentationDeriveFunction [ --help ] [ --check ] settingsFile'$'\n'''$'\n''    --help        Flag. Optional. Display this help.'$'\n''    --check       Flag. Optional. Check to see if an update is needed'$'\n''    settingsFile  File. Required. Settings file for function to document.'$'\n'''$'\n''Generate function derived files.'$'\n'''$'\n''File(s) are generated next to settingsFile.'$'\n'''$'\n''- --check checks to see if the file needs to be generated or updated. Returns 0 if up to date.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
