#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="name ... - String. Optional. Exit code value to output."$'\n'""
base="_sugar.sh"
description="Print one or more return codes by name."$'\n'""$'\n'"Known codes:"$'\n'""$'\n'"- \`success\` (0) - success!"$'\n'"- \`environment\` (1) - generic issue with environment"$'\n'"- \`argument\` (2) - issue with arguments"$'\n'"- \`assert\` (97) - assertion failed (ASCII 97 = \`a\`)"$'\n'"- \`identical\` (105) - identical check failed (ASCII 105 = \`i\`)"$'\n'"- \`leak\` (108) - function leaked globals (ASCII 108 = \`l\`)"$'\n'"- \`timeout\` (116) - timeout exceeded (ASCII 116 = \`t\`)"$'\n'"- \`exit\` - (120) exit function immediately (ASCII 120 = \`x\`)"$'\n'"- \`not-found\` - (127) command not found"$'\n'"- \`user-interrupt\` - (127) User interrupt (Ctrl-C)"$'\n'"- \`interrupt\` - (141) Interrupt signal"$'\n'"- \`internal\` - (253) internal errors"$'\n'""$'\n'"Unknown error code is 254, end of range is 255 which is not used. Use \`returnCodeString\` to get a string from an exit code integer."$'\n'""$'\n'"Return Code: 0 - success"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnCode"
requires="usageDocument printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux"$'\n'"returnCodeString"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Print one or more return codes by name."
usage="returnCode [ name ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreturnCode[0m [94m[ name ... ][0m

    [94mname ...  [1;97mString. Optional. Exit code value to output.[0m

Print one or more return codes by name.

Known codes:

- [38;2;0;255;0;48;2;0;0;0msuccess[0m (0) - success!
- [38;2;0;255;0;48;2;0;0;0menvironment[0m (1) - generic issue with environment
- [38;2;0;255;0;48;2;0;0;0margument[0m (2) - issue with arguments
- [38;2;0;255;0;48;2;0;0;0massert[0m (97) - assertion failed (ASCII 97 = [38;2;0;255;0;48;2;0;0;0ma[0m)
- [38;2;0;255;0;48;2;0;0;0midentical[0m (105) - identical check failed (ASCII 105 = [38;2;0;255;0;48;2;0;0;0mi[0m)
- [38;2;0;255;0;48;2;0;0;0mleak[0m (108) - function leaked globals (ASCII 108 = [38;2;0;255;0;48;2;0;0;0ml[0m)
- [38;2;0;255;0;48;2;0;0;0mtimeout[0m (116) - timeout exceeded (ASCII 116 = [38;2;0;255;0;48;2;0;0;0mt[0m)
- [38;2;0;255;0;48;2;0;0;0mexit[0m - (120) exit function immediately (ASCII 120 = [38;2;0;255;0;48;2;0;0;0mx[0m)
- [38;2;0;255;0;48;2;0;0;0mnot-found[0m - (127) command not found
- [38;2;0;255;0;48;2;0;0;0muser-interrupt[0m - (127) User interrupt (Ctrl-C)
- [38;2;0;255;0;48;2;0;0;0minterrupt[0m - (141) Interrupt signal
- [38;2;0;255;0;48;2;0;0;0minternal[0m - (253) internal errors

Unknown error code is 254, end of range is 255 which is not used. Use [38;2;0;255;0;48;2;0;0;0mreturnCodeString[0m to get a string from an exit code integer.

Return Code: 0 - success

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: returnCode [ name ... ]

    name ...  String. Optional. Exit code value to output.

Print one or more return codes by name.

Known codes:

- success (0) - success!
- environment (1) - generic issue with environment
- argument (2) - issue with arguments
- assert (97) - assertion failed (ASCII 97 = a)
- identical (105) - identical check failed (ASCII 105 = i)
- leak (108) - function leaked globals (ASCII 108 = l)
- timeout (116) - timeout exceeded (ASCII 116 = t)
- exit - (120) exit function immediately (ASCII 120 = x)
- not-found - (127) command not found
- user-interrupt - (127) User interrupt (Ctrl-C)
- interrupt - (141) Interrupt signal
- internal - (253) internal errors

Unknown error code is 254, end of range is 255 which is not used. Use returnCodeString to get a string from an exit code integer.

Return Code: 0 - success

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
