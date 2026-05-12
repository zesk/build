#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
line="527"
rawComment=$'Summary: Generate SEE markdown content\nGenerate `SEE/{fn}.md` - Derived file generator.\nFile is next to `settingsFile`; `--check` checks to see if the file needs to be generated or updated.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --check - Flag. Optional. Check to see if an update is needed\nArgument: settingsFile - File. Required. Settings file for function to document.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="0134555ea1c32d02fdc40fd9058827a280501390"
sourceLine="527"
summary="Generate SEE markdown content"
summaryComputed=""
usage="bashDocumentationDeriveSee [ --help ] [ --check ] settingsFile"
