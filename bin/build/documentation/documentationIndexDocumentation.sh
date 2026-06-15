#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--target targetDirectory - Directory. Optional. Directory where the index will be created. Uses `documentationCache` if not specified.\ndocumentationSource ... - Directory. OneOrMore. Documentation source path to find tokens and their definitions.\n--verbose - Flag. Optional. Extrapolate needlessly.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate the documentation index\nIndexes where functions are defined in documentation (e.g. `*.md` files - markdown files).\nFinds the appropriate token `{funcName}` and generates an index for linking or other purposes.\n\n'
descriptionLineCount="4"
file="bin/build/tools/documentation.sh"
fn="documentationIndexDocumentation"
fnMarker="documentationindexdocumentation"
foundNames=([0]="argument" [1]="return_code")
line="350"
rawComment=$'Generate the documentation index\nIndexes where functions are defined in documentation (e.g. `*.md` files - markdown files).\nFinds the appropriate token `{funcName}` and generates an index for linking or other purposes.\nArgument: --target targetDirectory - Directory. Optional. Directory where the index will be created. Uses `documentationCache` if not specified.\nArgument: documentationSource ... - Directory. OneOrMore. Documentation source path to find tokens and their definitions.\nArgument: --verbose - Flag. Optional. Extrapolate needlessly.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - If success\nReturn Code: 1 - Issue with file generation\nReturn Code: 2 - Argument error\n\n'
return_code=$'0 - If success\n1 - Issue with file generation\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="b31ecab0f7db7528ee0d4002e2ae77d5ce2c71c9"
sourceLine="350"
summary="Generate the documentation index"
summaryComputed="true"
usage="documentationIndexDocumentation [ --target targetDirectory ] [ documentationSource ... ] [ --verbose ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationIndexDocumentation'$'\e''[0m '$'\e''[[(blue)]m[ --target targetDirectory ]'$'\e''[0m '$'\e''[[(blue)]m[ documentationSource ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--target targetDirectory  '$'\e''[[(value)]mDirectory. Optional. Directory where the index will be created. Uses '$'\e''[[(code)]mdocumentationCache'$'\e''[[(reset)]m if not specified.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mdocumentationSource ...   '$'\e''[[(value)]mDirectory. OneOrMore. Documentation source path to find tokens and their definitions.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose                 '$'\e''[[(value)]mFlag. Optional. Extrapolate needlessly.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate the documentation index'$'\n''Indexes where functions are defined in documentation (e.g. '$'\e''[[(code)]m'$'\e''[[(cyan)]m.md'$'\e''[[(reset)]m files - markdown files).'$'\e''[[(reset)]m'$'\n''Finds the appropriate token '$'\e''[[(code)]m{funcName}'$'\e''[[(reset)]m and generates an index for linking or other purposes.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Issue with file generation'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationIndexDocumentation [ --target targetDirectory ] [ documentationSource ... ] [ --verbose ] [ --help ]'$'\n'''$'\n''    --target targetDirectory  Directory. Optional. Directory where the index will be created. Uses documentationCache if not specified.'$'\n''    documentationSource ...   Directory. OneOrMore. Documentation source path to find tokens and their definitions.'$'\n''    --verbose                 Flag. Optional. Extrapolate needlessly.'$'\n''    --help                    Flag. Optional. Display this help.'$'\n'''$'\n''Generate the documentation index'$'\n''Indexes where functions are defined in documentation (e.g. .md files - markdown files).'$'\n''Finds the appropriate token {funcName} and generates an index for linking or other purposes.'$'\n'''$'\n''Return codes:'$'\n''- 0 - If success'$'\n''- 1 - Issue with file generation'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
