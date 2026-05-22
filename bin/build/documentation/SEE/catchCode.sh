#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-22
# shellcheck disable=SC2034
argument="code - UnsignedInteger. Required. Exit code to return"$'\n'"handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"command ... - Callable. Required. Command to run."$'\n'"... - Arguments. Optional. Arguments to \`command\`"$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchCode"
fnMarker="catchcode"
foundNames=([0]="argument" [1]="requires")
line="194"
rawComment="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'"Argument: code - UnsignedInteger. Required. Exit code to return"$'\n'"Argument: handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`"$'\n'"Requires: isUnsignedInteger returnArgument isFunction isCallable"$'\n'""$'\n'""
requires="isUnsignedInteger returnArgument isFunction isCallable"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="859744e8330da27fd03e1da6874909739d06ce70"
sourceLine="194"
summary="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\`"
summaryComputed="true"
usage="catchCode code handler command ... [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchCode'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcode'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcode         '$'\e''[[(value)]mUnsignedInteger. Required. Exit code to return'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mhandler      '$'\e''[[(value)]mFunction. Required. Failure command, passed remaining arguments and error code.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcommand ...  '$'\e''[[(value)]mCallable. Required. Command to run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...          '$'\e''[[(value)]mArguments. Optional. Arguments to '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m, handle failure with '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with '$'\e''[[(code)]mcode'$'\e''[[(reset)]m and '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m as error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: catchCode code handler command ... [ ... ]'$'\n'''$'\n''    code         UnsignedInteger. Required. Exit code to return'$'\n''    handler      Function. Required. Failure command, passed remaining arguments and error code.'$'\n''    command ...  Callable. Required. Command to run.'$'\n''    ...          Arguments. Optional. Arguments to command'$'\n'''$'\n''Run command, handle failure with handler with code and command as error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar-core.md"
