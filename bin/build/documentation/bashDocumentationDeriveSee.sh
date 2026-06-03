#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-03
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--check - Flag. Optional. Check to see if an update is needed\nsettingsFile - File. Required. Settings file for function to document.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate `SEE/{fn}.md` - Derived file generator.\nFile is next to `settingsFile`; `--check` checks to see if the file needs to be generated or updated.\n\n'
descriptionLineCount="3"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationDeriveSee"
fnMarker="bashdocumentationderivesee"
foundNames=([0]="summary" [1]="argument")
line="872"
rawComment=$'Summary: Generate SEE markdown content\nGenerate `SEE/{fn}.md` - Derived file generator.\nFile is next to `settingsFile`; `--check` checks to see if the file needs to be generated or updated.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --check - Flag. Optional. Check to see if an update is needed\nArgument: settingsFile - File. Required. Settings file for function to document.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="a3794434b7e4d336ccd6c9cbf964150d59b552f0"
sourceLine="872"
summary="Generate SEE markdown content"
summaryComputed=""
usage="bashDocumentationDeriveSee [ --help ] [ --check ] settingsFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDocumentationDeriveSee'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --check ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msettingsFile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--check       '$'\e''[[(value)]mFlag. Optional. Check to see if an update is needed'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msettingsFile  '$'\e''[[(value)]mFile. Required. Settings file for function to document.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate '$'\e''[[(code)]mSEE/bashDocumentationDeriveSee.md'$'\e''[[(reset)]m - Derived file generator.'$'\n''File is next to '$'\e''[[(code)]msettingsFile'$'\e''[[(reset)]m; '$'\e''[[(code)]m--check'$'\e''[[(reset)]m checks to see if the file needs to be generated or updated.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashDocumentationDeriveSee [ --help ] [ --check ] settingsFile'$'\n'''$'\n''    --help        Flag. Optional. Display this help.'$'\n''    --check       Flag. Optional. Check to see if an update is needed'$'\n''    settingsFile  File. Required. Settings file for function to document.'$'\n'''$'\n''Generate SEE/bashDocumentationDeriveSee.md - Derived file generator.'$'\n''File is next to settingsFile; --check checks to see if the file needs to be generated or updated.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/internal.md"
