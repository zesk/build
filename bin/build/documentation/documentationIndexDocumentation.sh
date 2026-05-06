#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--target targetDirectory - Directory. Optional. Directory where the index will be created. Uses \`documentationCache\` if not specified."$'\n'"documentationSource ... - Directory. OneOrMore. Documentation source path to find tokens and their definitions."$'\n'"--verbose - Flag. Optional. Extrapolate needlessly."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generate the documentation index"$'\n'"Indexes where functions are defined in documentation (e.g. \`*.md\` files - markdown files)."$'\n'"Finds the appropriate token \`{funcName}\` and generates an index for linking or other purposes."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/documentation.sh"
fn="documentationIndexDocumentation"
fnMarker="documentationindexdocumentation"
foundNames=([0]="argument" [1]="return_code")
line="337"
rawComment="Generate the documentation index"$'\n'"Indexes where functions are defined in documentation (e.g. \`*.md\` files - markdown files)."$'\n'"Finds the appropriate token \`{funcName}\` and generates an index for linking or other purposes."$'\n'"Argument: --target targetDirectory - Directory. Optional. Directory where the index will be created. Uses \`documentationCache\` if not specified."$'\n'"Argument: documentationSource ... - Directory. OneOrMore. Documentation source path to find tokens and their definitions."$'\n'"Argument: --verbose - Flag. Optional. Extrapolate needlessly."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - If success"$'\n'"1 - Issue with file generation"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7487e1e4be50d4eb634f007bfd41adda45ab6d68"
sourceLine="337"
summary="Generate the documentation index"
summaryComputed="true"
usage="documentationIndexDocumentation [ --target targetDirectory ] [ documentationSource ... ] [ --verbose ] [ --help ]"
