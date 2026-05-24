#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
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
line="572"
rawComment=$'Summary: Generate markdown documentation page\nGenerate function derived files.\nFile(s) are generated next to `settingsFile`.\n- `--check` checks to see if the file needs to be generated or updated. Returns 0 if up to date.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --check - Flag. Optional. Check to see if an update is needed\nArgument: settingsFile - File. Required. Settings file for function to document.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fa382137d00499e888f4c9bf0ffc9e1256277eb1"
sourceLine="572"
summary="Generate markdown documentation page"
summaryComputed=""
usage="bashDocumentationDeriveFunction [ --help ] [ --check ] settingsFile"
