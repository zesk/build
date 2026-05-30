#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-27
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\npattern ... - String. Required.`grep -e` Pattern to find in files. No quoting is added so ensure these are compatible with `grep -e`.\n-- - Delimiter. Required. exception.\nexception ... - String. Optional. `grep -e` File pattern which should be ignored.\n-- - Delimiter. Required. file.\nfile ... - File. Required. File to search. Special file `-` indicates files should be read from `stdin`.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Find one or more patterns in a list of files, with a list of file name pattern exceptions.\n\n'
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileMatches"
fnMarker="filematches"
foundNames=([0]="argument")
line="666"
rawComment=$'Find one or more patterns in a list of files, with a list of file name pattern exceptions.\nArgument: --help - Flag. Optional. Display this help.\nArgument: pattern ... - String. Required.`grep -e` Pattern to find in files. No quoting is added so ensure these are compatible with `grep -e`.\nArgument: -- - Delimiter. Required. exception.\nArgument: exception ... - String. Optional. `grep -e` File pattern which should be ignored.\nArgument: -- - Delimiter. Required. file.\nArgument: file ... - File. Required. File to search. Special file `-` indicates files should be read from `stdin`.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="bbae84ac54a20b3ed2a0936cd425f12f62a59d01"
sourceLine="666"
summary="Find one or more patterns in a list of files,"
summaryComputed="true"
usage="fileMatches [ --help ] pattern ... -- [ exception ... ] -- file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileMatches'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpattern ...'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m '$'\e''[[(blue)]m[ exception ... ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpattern ...    '$'\e''[[(value)]mString. Required.'$'\e''[[(code)]mgrep -e'$'\e''[[(reset)]m Pattern to find in files. No quoting is added so ensure these are compatible with '$'\e''[[(code)]mgrep -e'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--             '$'\e''[[(value)]mDelimiter. Required. exception.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mexception ...  '$'\e''[[(value)]mString. Optional. '$'\e''[[(code)]mgrep -e'$'\e''[[(reset)]m File pattern which should be ignored.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--             '$'\e''[[(value)]mDelimiter. Required. file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile ...       '$'\e''[[(value)]mFile. Required. File to search. Special file '$'\e''[[(code)]m-'$'\e''[[(reset)]m indicates files should be read from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Find one or more patterns in a list of files, with a list of file name pattern exceptions.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: fileMatches [ --help ] pattern ...  [ exception ... ]  file ...'$'\n'''$'\n''    --help         Flag. Optional. Display this help.'$'\n''    pattern ...    String. Required.grep -e Pattern to find in files. No quoting is added so ensure these are compatible with grep -e.'$'\n''    --             Delimiter. Required. exception.'$'\n''    exception ...  String. Optional. grep -e File pattern which should be ignored.'$'\n''    --             Delimiter. Required. file.'$'\n''    file ...       File. Required. File to search. Special file - indicates files should be read from stdin.'$'\n'''$'\n''Find one or more patterns in a list of files, with a list of file name pattern exceptions.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/file.md"
