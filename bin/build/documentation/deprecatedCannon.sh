#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--path cannonPath - Directory. Optional. Run textCannon operation starting in this directory."$'\n'"findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"search - String. Required. String to search for"$'\n'"replace - EmptyString. Required. Replacement string."$'\n'"extraCannonArguments - Arguments. Optional. Any additional arguments are passed to \`cannon\`."$'\n'""
base="deprecated-tools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="No documentation for \`deprecatedCannon\`."$'\n'""
descriptionLineCount=""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedCannon"
fnMarker="deprecatedcannon"
foundNames=([0]="argument")
line="289"
rawComment="Argument: --path cannonPath - Directory. Optional. Run textCannon operation starting in this directory."$'\n'"Argument: findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"Argument: search - String. Required. String to search for"$'\n'"Argument: replace - EmptyString. Required. Replacement string."$'\n'"Argument: extraCannonArguments - Arguments. Optional. Any additional arguments are passed to \`cannon\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="1121098df87cee32b55dc85263f73f68977219d8"
sourceLine="289"
summary="undocumented"
summaryComputed=""
usage="deprecatedCannon [ --path cannonPath ] findArgumentFunction search replace [ extraCannonArguments ]"
