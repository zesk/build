#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"pattern ... - String. Required.\`grep -e\` Pattern to find in files."$'\n'"-- - Delimiter. Required. exception."$'\n'"exception ... - String. Optional. \`grep -e\` File pattern which should be ignored."$'\n'"-- - Delimiter. Required. file."$'\n'"file ... - File. Required. File to search. Special file \`-\` indicates files should be read from \`stdin\`."$'\n'""
base="file.sh"
description="Find list of files which do NOT match a specific pattern or patterns and output them"$'\n'""
exitCode="0"
file="bin/build/tools/file.sh"
foundNames=([0]="argument")
rawComment="Find list of files which do NOT match a specific pattern or patterns and output them"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: pattern ... - String. Required.\`grep -e\` Pattern to find in files."$'\n'"Argument: -- - Delimiter. Required. exception."$'\n'"Argument: exception ... - String. Optional. \`grep -e\` File pattern which should be ignored."$'\n'"Argument: -- - Delimiter. Required. file."$'\n'"Argument: file ... - File. Required. File to search. Special file \`-\` indicates files should be read from \`stdin\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
summary="Find list of files which do NOT match a specific"
usage="fileNotMatches [ --help ] pattern ... -- [ exception ... ] -- file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mfileNotMatches'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mpattern ...'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]m '$'\e''[[blue]m[ exception ... ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]m '$'\e''[[bold]m'$'\e''[[magenta]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help         '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mpattern ...    '$'\e''[[value]mString. Required.'$'\e''[[code]mgrep -e'$'\e''[[reset]m Pattern to find in files.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]m--             '$'\e''[[value]mDelimiter. Required. exception.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mexception ...  '$'\e''[[value]mString. Optional. '$'\e''[[code]mgrep -e'$'\e''[[reset]m File pattern which should be ignored.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]m--             '$'\e''[[value]mDelimiter. Required. file.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mfile ...       '$'\e''[[value]mFile. Required. File to search. Special file '$'\e''[[code]m-'$'\e''[[reset]m indicates files should be read from '$'\e''[[code]mstdin'$'\e''[[reset]m.'$'\e''[[reset]m'$'\n'''$'\n''Find list of files which do NOT match a specific pattern or patterns and output them'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileNotMatches [ --help ] pattern ...  [ exception ... ]  file ...'$'\n'''$'\n''    --help         Flag. Optional. Display this help.'$'\n''    pattern ...    String. Required.grep -e Pattern to find in files.'$'\n''    --             Delimiter. Required. exception.'$'\n''    exception ...  String. Optional. grep -e File pattern which should be ignored.'$'\n''    --             Delimiter. Required. file.'$'\n''    file ...       File. Required. File to search. Special file - indicates files should be read from stdin.'$'\n'''$'\n''Find list of files which do NOT match a specific pattern or patterns and output them'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
