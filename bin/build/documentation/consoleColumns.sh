#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Output the number of columns in the terminal. Default is 80 if not able to be determined from \`TERM\`."$'\n'"Side Effect: MAY define two environment variables"$'\n'""
environment="- \`COLUMNS\` - May be defined after calling this"$'\n'"- \`LINES\` - May be defined after calling this"$'\n'""
example="    repeat \$(consoleColumns)"$'\n'""
file="bin/build/tools/colors.sh"
fn="consoleColumns"
foundNames=([0]="summary" [1]="stdout" [2]="argument" [3]="see" [4]="example" [5]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty"$'\n'""
source="bin/build/tools/colors.sh"
sourceModified="1768757397"
stdout="Integer"$'\n'""
summary="Column count in current console"$'\n'""
usage="consoleColumns [ --help ]"
