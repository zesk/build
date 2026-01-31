#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="date.sh"
description="Converts a date (\`YYYY-MM-DD\`) to another format."$'\n'"Summary: Platform agnostic date conversion"$'\n'"Compatible with BSD and GNU date."$'\n'"Argument: date - String. Required. String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"Argument: format - String. Optional. Format string for the \`date\` command (e.g. \`%s\`)"$'\n'"Example:     dateToFormat 2023-04-20 %s 1681948800"$'\n'"Example:     timestamp=\$(dateToFormat '2023-10-15' %s)"$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'""
file="bin/build/tools/date.sh"
foundNames=()
rawComment="Converts a date (\`YYYY-MM-DD\`) to another format."$'\n'"Summary: Platform agnostic date conversion"$'\n'"Compatible with BSD and GNU date."$'\n'"Argument: date - String. Required. String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"Argument: format - String. Optional. Format string for the \`date\` command (e.g. \`%s\`)"$'\n'"Example:     dateToFormat 2023-04-20 %s 1681948800"$'\n'"Example:     timestamp=\$(dateToFormat '2023-10-15' %s)"$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Converts a date (\`YYYY-MM-DD\`) to another format."
usage="dateToFormat"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateToFormat'$'\e''[0m'$'\n'''$'\n''Converts a date ('$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m) to another format.'$'\n''Summary: Platform agnostic date conversion'$'\n''Compatible with BSD and GNU date.'$'\n''Argument: date - String. Required. String in the form '$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m (e.g. '$'\e''[[(code)]m2023-10-15'$'\e''[[(reset)]m)'$'\n''Argument: format - String. Optional. Format string for the '$'\e''[[(code)]mdate'$'\e''[[(reset)]m command (e.g. '$'\e''[[(code)]m%s'$'\e''[[(reset)]m)'$'\n''Example:     dateToFormat 2023-04-20 %s 1681948800'$'\n''Example:     timestamp=$(dateToFormat '\''2023-10-15'\'' %s)'$'\n''Return Code: 1 - if parsing fails'$'\n''Return Code: 0 - if parsing succeeds'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateToFormat'$'\n'''$'\n''Converts a date (YYYY-MM-DD) to another format.'$'\n''Summary: Platform agnostic date conversion'$'\n''Compatible with BSD and GNU date.'$'\n''Argument: date - String. Required. String in the form YYYY-MM-DD (e.g. 2023-10-15)'$'\n''Argument: format - String. Optional. Format string for the date command (e.g. %s)'$'\n''Example:     dateToFormat 2023-04-20 %s 1681948800'$'\n''Example:     timestamp=$(dateToFormat '\''2023-10-15'\'' %s)'$'\n''Return Code: 1 - if parsing fails'$'\n''Return Code: 0 - if parsing succeeds'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.463
