#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="link - EmptyString. Required. Link to output."$'\n'"text - String. Optional. Text to display, if none then uses \`link\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output a hyperlink to the console"$'\n'"OSC 8 standard for terminals"$'\n'"No way to test ability, I think. Maybe \`tput\`."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/console.sh"
fn="consoleLink"
fnMarker="consolelink"
foundNames=([0]="summary" [1]="argument")
line="191"
rawComment="Summary: console hyperlinks"$'\n'"Output a hyperlink to the console"$'\n'"OSC 8 standard for terminals"$'\n'"No way to test ability, I think. Maybe \`tput\`."$'\n'"Argument: link - EmptyString. Required. Link to output."$'\n'"Argument: text - String. Optional. Text to display, if none then uses \`link\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/console.sh"
sourceHash="82d47fdc5820e57d7aeb7f061bb09ecb16c35cd7"
sourceLine="191"
summary="console hyperlinks"
summaryComputed=""
usage="consoleLink link [ text ] [ --help ]"
