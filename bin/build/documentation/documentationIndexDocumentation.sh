#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
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
line="337"
rawComment=$'Generate the documentation index\nIndexes where functions are defined in documentation (e.g. `*.md` files - markdown files).\nFinds the appropriate token `{funcName}` and generates an index for linking or other purposes.\nArgument: --target targetDirectory - Directory. Optional. Directory where the index will be created. Uses `documentationCache` if not specified.\nArgument: documentationSource ... - Directory. OneOrMore. Documentation source path to find tokens and their definitions.\nArgument: --verbose - Flag. Optional. Extrapolate needlessly.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - If success\nReturn Code: 1 - Issue with file generation\nReturn Code: 2 - Argument error\n\n'
return_code=$'0 - If success\n1 - Issue with file generation\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fa382137d00499e888f4c9bf0ffc9e1256277eb1"
sourceLine="337"
summary="Generate the documentation index"
summaryComputed="true"
usage="documentationIndexDocumentation [ --target targetDirectory ] [ documentationSource ... ] [ --verbose ] [ --help ]"
