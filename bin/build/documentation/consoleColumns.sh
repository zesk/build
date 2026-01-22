#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Output the number of columns in the terminal. Default is 80 if not able to be determined from \`TERM\`."$'\n'"Side Effect: MAY define two environment variables"$'\n'""
environment="- \`COLUMNS\` - May be defined after calling this"$'\n'"- \`LINES\` - May be defined after calling this"$'\n'""
example="    repeat \$(consoleColumns)"$'\n'""
file="bin/build/tools/colors.sh"
fn="consoleColumns"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
stdout="Integer"$'\n'""
summary="Column count in current console"$'\n'""
usage="consoleColumns [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconsoleColumns[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Output the number of columns in the terminal. Default is 80 if not able to be determined from [38;2;0;255;0;48;2;0;0;0mTERM[0m.
Side Effect: MAY define two environment variables

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- - [38;2;0;255;0;48;2;0;0;0mCOLUMNS[0m - May be defined after calling this
- - [38;2;0;255;0;48;2;0;0;0mLINES[0m - May be defined after calling this
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Integer

Example:
    repeat $(consoleColumns)
'
# shellcheck disable=SC2016
helpPlain='Usage: consoleColumns [ --help ]

    --help  Flag. Optional. Display this help.

Output the number of columns in the terminal. Default is 80 if not able to be determined from TERM.
Side Effect: MAY define two environment variables

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- - COLUMNS - May be defined after calling this
- - LINES - May be defined after calling this
- 

Writes to stdout:
Integer

Example:
    repeat $(consoleColumns)
'
