#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Output the number of columns in the terminal. Default is 60 if not able to be determined from \`TERM\`."$'\n'""
environment="- \`COLUMNS\` - May be defined after calling this"$'\n'"- \`LINES\` - May be defined after calling this"$'\n'""
example="    tail -n \$(consoleRows) \"\$file\""$'\n'""
file="bin/build/tools/colors.sh"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="example" [4]="environment" [5]="side_effect")
rawComment="Summary: Row count in current console"$'\n'"Output the number of columns in the terminal. Default is 60 if not able to be determined from \`TERM\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: stty"$'\n'"Example:     tail -n \$(consoleRows) \"\$file\""$'\n'"Environment: - \`COLUMNS\` - May be defined after calling this"$'\n'"Environment: - \`LINES\` - May be defined after calling this"$'\n'"Side Effect: MAY define two environment variables"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty"$'\n'""
side_effect="MAY define two environment variables"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1769211509"
summary="Row count in current console"$'\n'""
usage="consoleRows [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleRows'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the number of columns in the terminal. Default is 60 if not able to be determined from '$'\e''[[(code)]mTERM'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mCOLUMNS'$'\e''[[(reset)]m - May be defined after calling this'$'\n''- '$'\e''[[(code)]mLINES'$'\e''[[(reset)]m - May be defined after calling this'$'\n'''$'\n''Example:'$'\n''    tail -n $(consoleRows) "$file"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleRows [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Output the number of columns in the terminal. Default is 60 if not able to be determined from TERM.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- COLUMNS - May be defined after calling this'$'\n''- LINES - May be defined after calling this'$'\n'''$'\n''Example:'$'\n''    tail -n $(consoleRows) "$file"'$'\n'''
# elapsed 0.538
