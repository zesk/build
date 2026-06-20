#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'handler - Function. Required. Failure command\nquietLog - File. Required. File to output log to temporarily for this command. If `quietLog` is `-` then creates a temporary file for the command which is deleted automatically.\ncommand ... - Callable. Required. Thing to run and append output to `quietLog`.\n'
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `handler` with an environment error\n\n'
descriptionLineCount="2"
file="bin/build/tools/sugar.sh"
fn="catchEnvironmentQuiet"
fnMarker="catchenvironmentquiet"
foundNames=([0]="argument" [1]="requires")
line="16"
original="catchEnvironmentQuiet"
rawComment=$'Run `handler` with an environment error\nArgument: handler - Function. Required. Failure command\nArgument: quietLog - File. Required. File to output log to temporarily for this command. If `quietLog` is `-` then creates a temporary file for the command which is deleted automatically.\nArgument: command ... - Callable. Required. Thing to run and append output to `quietLog`.\nRequires: isFunction returnArgument debuggingStack throwEnvironment\n\n'
requires=$'isFunction returnArgument debuggingStack throwEnvironment\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="16"
summary="Run \`handler\` with an environment error"
summaryComputed="true"
usage="catchEnvironmentQuiet handler quietLog command ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchEnvironmentQuiet'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mquietLog'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler      '$'\e''[[(value)]mFunction. Required. Failure command'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mquietLog     '$'\e''[[(value)]mFile. Required. File to output log to temporarily for this command. If '$'\e''[[(code)]mquietLog'$'\e''[[(reset)]m is '$'\e''[[(code)]m-'$'\e''[[(reset)]m then creates a temporary file for the command which is deleted automatically.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcommand ...  '$'\e''[[(value)]mCallable. Required. Thing to run and append output to '$'\e''[[(code)]mquietLog'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with an environment error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: catchEnvironmentQuiet handler quietLog command ...'$'\n'''$'\n''    handler      Function. Required. Failure command'$'\n''    quietLog     File. Required. File to output log to temporarily for this command. If quietLog is - then creates a temporary file for the command which is deleted automatically.'$'\n''    command ...  Callable. Required. Thing to run and append output to quietLog.'$'\n'''$'\n''Run handler with an environment error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar.md"
