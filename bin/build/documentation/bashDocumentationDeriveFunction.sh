#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--check - Flag. Optional. Check to see if an update is needed"$'\n'"settingsFile - File. Required. Settings file for function to document."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generate function derived files."$'\n'""$'\n'"File(s) are generated next to \`settingsFile\`."$'\n'""$'\n'"- \`--check\` checks to see if the file needs to be generated or updated. Returns 0 if up to date."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationDeriveFunction"
fnMarker="bashdocumentationderivefunction"
foundNames=([0]="summary" [1]="argument")
line="484"
rawComment="Summary: Generate markdown documentation page"$'\n'"Generate function derived files."$'\n'"File(s) are generated next to \`settingsFile\`."$'\n'"- \`--check\` checks to see if the file needs to be generated or updated. Returns 0 if up to date."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --check - Flag. Optional. Check to see if an update is needed"$'\n'"Argument: settingsFile - File. Required. Settings file for function to document."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7487e1e4be50d4eb634f007bfd41adda45ab6d68"
sourceLine="484"
summary="Generate markdown documentation page"
summaryComputed=""
usage="bashDocumentationDeriveFunction [ --help ] [ --check ] settingsFile"
