#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Find list of files which do NOT match a specific pattern or patterns and output them"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: pattern ... - String. Required.\`grep -e\` Pattern to find in files."$'\n'"Argument: -- - Delimiter. Required. exception."$'\n'"Argument: exception ... - String. Optional. \`grep -e\` File pattern which should be ignored."$'\n'"Argument: -- - Delimiter. Required. file."$'\n'"Argument: file ... - File. Required. File to search. Special file \`-\` indicates files should be read from \`stdin\`."$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Find list of files which do NOT match a specific pattern or patterns and output them"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: pattern ... - String. Required.\`grep -e\` Pattern to find in files."$'\n'"Argument: -- - Delimiter. Required. exception."$'\n'"Argument: exception ... - String. Optional. \`grep -e\` File pattern which should be ignored."$'\n'"Argument: -- - Delimiter. Required. file."$'\n'"Argument: file ... - File. Required. File to search. Special file \`-\` indicates files should be read from \`stdin\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Find list of files which do NOT match a specific"
usage="fileNotMatches"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileNotMatches'$'\e''[0m'$'\n'''$'\n''Find list of files which do NOT match a specific pattern or patterns and output them'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: pattern ... - String. Required.'$'\e''[[(code)]mgrep -e'$'\e''[[(reset)]m Pattern to find in files.'$'\n''Argument: -- - Delimiter. Required. exception.'$'\n''Argument: exception ... - String. Optional. '$'\e''[[(code)]mgrep -e'$'\e''[[(reset)]m File pattern which should be ignored.'$'\n''Argument: -- - Delimiter. Required. file.'$'\n''Argument: file ... - File. Required. File to search. Special file '$'\e''[[(code)]m-'$'\e''[[(reset)]m indicates files should be read from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileNotMatches'$'\n'''$'\n''Find list of files which do NOT match a specific pattern or patterns and output them'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: pattern ... - String. Required.grep -e Pattern to find in files.'$'\n''Argument: -- - Delimiter. Required. exception.'$'\n''Argument: exception ... - String. Optional. grep -e File pattern which should be ignored.'$'\n''Argument: -- - Delimiter. Required. file.'$'\n''Argument: file ... - File. Required. File to search. Special file - indicates files should be read from stdin.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.488
