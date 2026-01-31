#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
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
sourceHash="9f54e9ae3d6bd1960826e3412b3edfd9c241f895"
summary="Row count in current console"$'\n'""
usage="consoleRows [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleRows'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the number of columns in the terminal. Default is 60 if not able to be determined from '$'\e''[[(code)]mTERM'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mCOLUMNS'$'\e''[[(reset)]m - May be defined after calling this'$'\n''- '$'\e''[[(code)]mLINES'$'\e''[[(reset)]m - May be defined after calling this'$'\n'''$'\n''Example:'$'\n''    tail -n $(consoleRows) "$file"'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mconsoleRows [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Output the number of columns in the terminal. Default is 60 if not able to be determined from [[(code)]mTERM.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- [[(code)]mCOLUMNS - May be defined after calling this'$'\n''- [[(code)]mLINES - May be defined after calling this'$'\n'''$'\n''Example:'$'\n''    tail -n $(consoleRows) "$file"'$'\n'''
# elapsed 4.096
