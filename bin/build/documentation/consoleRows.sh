#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Output the number of columns in the terminal. Default is 60 if not able to be determined from \`TERM\`."$'\n'"Side Effect: MAY define two environment variables"$'\n'""
environment="- \`COLUMNS\` - May be defined after calling this"$'\n'"- \`LINES\` - May be defined after calling this"$'\n'""
example="    tail -n \$(consoleRows) \"\$file\""$'\n'""
file="bin/build/tools/colors.sh"
fn="consoleRows"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1769063211"
summary="Row count in current console"$'\n'""
usage="consoleRows [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconsoleRows[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Output the number of columns in the terminal. Default is 60 if not able to be determined from [38;2;0;255;0;48;2;0;0;0mTERM[0m.
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

Example:
    tail -n $(consoleRows) "$file"
'
# shellcheck disable=SC2016
helpPlain='Usage: consoleRows [ --help ]

    --help  Flag. Optional. Display this help.

Output the number of columns in the terminal. Default is 60 if not able to be determined from TERM.
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

Example:
    tail -n $(consoleRows) "$file"
'
