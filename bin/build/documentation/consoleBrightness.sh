#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/console.sh"
argument="--foreground - Flag. Optional. Get the console text color."$'\n'"--background - Flag. Optional. Get the console background color."$'\n'""
base="console.sh"
description="Fetch the brightness of the console using \`consoleGetColor\`"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - A problem occurred with \`consoleGetColor\`"$'\n'""
file="bin/build/tools/console.sh"
fn="consoleBrightness"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="output")
output="Integer. between 0 and 100."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="consoleGetColor"$'\n'""
source="bin/build/tools/console.sh"
sourceModified="1768721469"
summary="Output the brightness of the background color of the console as a number between 0 and 100"$'\n'""
usage="consoleBrightness [ --foreground ] [ --background ]"
