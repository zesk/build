#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'handler - Function. Required. Failure command\nmessage ... - String. Optional. Error message to display.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `handler` with an argument error\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="throwArgument"
fnMarker="throwargument"
foundNames=([0]="argument" [1]="requires")
line="215"
rawComment=$'Run `handler` with an argument error\nArgument: handler - Function. Required. Failure command\nArgument: message ... - String. Optional. Error message to display.\nRequires: isFunction returnArgument decorate debuggingStack\n\n'
requires=$'isFunction returnArgument decorate debuggingStack\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="215"
summary="Run \`handler\` with an argument error"
summaryComputed="true"
usage="throwArgument handler [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mthrowArgument'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler      '$'\e''[[(value)]mFunction. Required. Failure command'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Error message to display.'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with an argument error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: throwArgument handler [ message ... ]'$'\n'''$'\n''    handler      Function. Required. Failure command'$'\n''    message ...  String. Optional. Error message to display.'$'\n'''$'\n''Run handler with an argument error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar-core.md"
