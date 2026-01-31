#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="colors.sh"
description="Summary: Row count in current console"$'\n'"Output the number of columns in the terminal. Default is 60 if not able to be determined from \`TERM\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: stty"$'\n'"Example:     tail -n \$(consoleRows) \"\$file\""$'\n'"Environment: - \`COLUMNS\` - May be defined after calling this"$'\n'"Environment: - \`LINES\` - May be defined after calling this"$'\n'"Side Effect: MAY define two environment variables"$'\n'""
file="bin/build/tools/colors.sh"
foundNames=()
rawComment="Summary: Row count in current console"$'\n'"Output the number of columns in the terminal. Default is 60 if not able to be determined from \`TERM\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: stty"$'\n'"Example:     tail -n \$(consoleRows) \"\$file\""$'\n'"Environment: - \`COLUMNS\` - May be defined after calling this"$'\n'"Environment: - \`LINES\` - May be defined after calling this"$'\n'"Side Effect: MAY define two environment variables"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="9f54e9ae3d6bd1960826e3412b3edfd9c241f895"
summary="Summary: Row count in current console"
usage="consoleRows"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleRows'$'\e''[0m'$'\n'''$'\n''Summary: Row count in current console'$'\n''Output the number of columns in the terminal. Default is 60 if not able to be determined from '$'\e''[[(code)]mTERM'$'\e''[[(reset)]m.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: stty'$'\n''Example:     tail -n $(consoleRows) "$file"'$'\n''Environment: - '$'\e''[[(code)]mCOLUMNS'$'\e''[[(reset)]m - May be defined after calling this'$'\n''Environment: - '$'\e''[[(code)]mLINES'$'\e''[[(reset)]m - May be defined after calling this'$'\n''Side Effect: MAY define two environment variables'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleRows'$'\n'''$'\n''Summary: Row count in current console'$'\n''Output the number of columns in the terminal. Default is 60 if not able to be determined from TERM.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: stty'$'\n''Example:     tail -n $(consoleRows) "$file"'$'\n''Environment: - COLUMNS - May be defined after calling this'$'\n''Environment: - LINES - May be defined after calling this'$'\n''Side Effect: MAY define two environment variables'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.466
