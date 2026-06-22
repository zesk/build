#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'prefix - ApplicationDirectory. Required. Relative path from the application directory to the subdirectory.\ntestFunction - Function. Required. Function which MUST be defined in the subdirectory sources.\nsubdirectory - RelativeDirectory. Required. Path added to `prefix` to load files.\nhandler - Function. Required. Error handler.\nfunction - Function. Required. Function to call; first argument will be `handler`.\n'
base="tools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Loads conditional code based on whether a function is defined yet\nArgument ... - Arguments. Optional. Additional arguments to the function.\n\n'
descriptionLineCount="3"
file="bin/build/tools.sh"
fn="__functionLoader"
fnMarker="__functionloader"
foundNames=([0]="argument")
line="57"
original="__functionLoader"
rawComment=$'Loads conditional code based on whether a function is defined yet\nArgument: prefix - ApplicationDirectory. Required. Relative path from the application directory to the subdirectory.\nArgument: testFunction - Function. Required. Function which MUST be defined in the subdirectory sources.\nArgument: subdirectory - RelativeDirectory. Required. Path added to `prefix` to load files.\nArgument: handler - Function. Required. Error handler.\nArgument: function - Function. Required. Function to call; first argument will be `handler`.\nArgument ... - Arguments. Optional. Additional arguments to the function.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools.sh"
sourceHash="f5113fd8fb36068200d8ec50005ec2707067bfe3"
sourceLine="57"
summary="Loads conditional code based on whether a function is defined"
summaryComputed="true"
usage="__functionLoader prefix testFunction subdirectory handler function"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__functionLoader'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mprefix'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtestFunction'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msubdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunction'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mprefix        '$'\e''[[(value)]mApplicationDirectory. Required. Relative path from the application directory to the subdirectory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtestFunction  '$'\e''[[(value)]mFunction. Required. Function which MUST be defined in the subdirectory sources.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msubdirectory  '$'\e''[[(value)]mRelativeDirectory. Required. Path added to '$'\e''[[(code)]mprefix'$'\e''[[(reset)]m to load files.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mhandler       '$'\e''[[(value)]mFunction. Required. Error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunction      '$'\e''[[(value)]mFunction. Required. Function to call; first argument will be '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Loads conditional code based on whether a function is defined yet'$'\n''Argument ... - Arguments. Optional. Additional arguments to the function.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __functionLoader prefix testFunction subdirectory handler function'$'\n'''$'\n''    prefix        ApplicationDirectory. Required. Relative path from the application directory to the subdirectory.'$'\n''    testFunction  Function. Required. Function which MUST be defined in the subdirectory sources.'$'\n''    subdirectory  RelativeDirectory. Required. Path added to prefix to load files.'$'\n''    handler       Function. Required. Error handler.'$'\n''    function      Function. Required. Function to call; first argument will be handler.'$'\n'''$'\n''Loads conditional code based on whether a function is defined yet'$'\n''Argument ... - Arguments. Optional. Additional arguments to the function.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
