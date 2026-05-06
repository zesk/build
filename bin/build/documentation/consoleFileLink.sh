#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--no-app - Flag. Optional. Do not map the application path in \`decoratePath\`"$'\n'"fileName - String. Required. File path to output."$'\n'"text - String. Optional. Text to output linked to file."$'\n'""
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output a local file link to the console"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/console.sh"
fn="consoleFileLink"
fnMarker="consolefilelink"
foundNames=([0]="argument")
line="225"
rawComment="Output a local file link to the console"$'\n'"Argument: --no-app - Flag. Optional. Do not map the application path in \`decoratePath\`"$'\n'"Argument: fileName - String. Required. File path to output."$'\n'"Argument: text - String. Optional. Text to output linked to file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="82d47fdc5820e57d7aeb7f061bb09ecb16c35cd7"
sourceLine="225"
summary="Output a local file link to the console"
summaryComputed="true"
usage="consoleFileLink [ --no-app ] fileName [ text ]"
