#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/console.sh"
argument="link - EmptyString. Required. Link to output."$'\n'"text - String. Optional. Text to display, if none then uses \`link\`."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="console.sh"
description="Output a hyperlink to the console"$'\n'"OSC 8 standard for terminals"$'\n'"No way to test ability, I think. Maybe \`tput\`."$'\n'""
file="bin/build/tools/console.sh"
fn="consoleLink"
foundNames=([0]="summary" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/console.sh"
sourceModified="1768683751"
summary="console hyperlinks"$'\n'""
usage="consoleLink link [ text ] [ --help ]"
