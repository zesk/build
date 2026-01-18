#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="name ... - String. Optional. Exit code value to output."$'\n'""
base="_sugar.sh"
description="Print one or more return codes by name."$'\n'""$'\n'"Known codes:"$'\n'""$'\n'"- \`success\` (0) - success!"$'\n'"- \`environment\` (1) - generic issue with environment"$'\n'"- \`argument\` (2) - issue with arguments"$'\n'"- \`assert\` (97) - assertion failed (ASCII 97 = \`a\`)"$'\n'"- \`identical\` (105) - identical check failed (ASCII 105 = \`i\`)"$'\n'"- \`leak\` (108) - function leaked globals (ASCII 108 = \`l\`)"$'\n'"- \`timeout\` (116) - timeout exceeded (ASCII 116 = \`t\`)"$'\n'"- \`exit\` - (120) exit function immediately (ASCII 120 = \`x\`)"$'\n'"- \`not-found\` - (127) command not found"$'\n'"- \`user-interrupt\` - (127) User interrupt (Ctrl-C)"$'\n'"- \`interrupt\` - (141) Interrupt signal"$'\n'"- \`internal\` - (253) internal errors"$'\n'""$'\n'"Unknown error code is 254, end of range is 255 which is not used. Use \`returnCodeString\` to get a string from an exit code integer."$'\n'""$'\n'"Return Code: 0 - success"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnCode"
foundNames=([0]="argument" [1]="see" [2]="file" [3]="requires")
requires="usageDocument printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux"$'\n'"returnCodeString"$'\n'""
source="bin/build/tools/_sugar.sh"
sourceModified="1768695727"
summary="Print one or more return codes by name."
usage="returnCode [ name ... ]"
