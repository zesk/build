#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="findArgumentFunction - Function. Required. Find arguments (for \`find\`) for \`textCannon\`."$'\n'"search - String. Required. String to search for (one or more)"$'\n'"--path cannonPath - Directory. Optional. Run \`textCannon\` operation starting in this directory."$'\n'""
base="deprecated-tools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Find files which match a token or tokens"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedFind"
fnMarker="deprecatedfind"
foundNames=([0]="return_code" [1]="argument" [2]="see")
line="243"
rawComment="Find files which match a token or tokens"$'\n'"Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)"$'\n'"Return Code: 1 - Search tokens were not found in any file (which matches find arguments)"$'\n'"Argument: findArgumentFunction - Function. Required. Find arguments (for \`find\`) for \`textCannon\`."$'\n'"Argument: search - String. Required. String to search for (one or more)"$'\n'"Argument: --path cannonPath - Directory. Optional. Run \`textCannon\` operation starting in this directory."$'\n'"See: buildHome"$'\n'""$'\n'""
return_code="0 - One of the search tokens was found in a file (which matches find arguments)"$'\n'"1 - Search tokens were not found in any file (which matches find arguments)"$'\n'""
see="buildHome"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="1121098df87cee32b55dc85263f73f68977219d8"
sourceLine="243"
summary="Find files which match a token or tokens"
summaryComputed="true"
usage="deprecatedFind findArgumentFunction search [ --path cannonPath ]"
