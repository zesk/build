#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="handler - Function. Required. Error handler."$'\n'"binary ... - Executable. Required. Any arguments are passed to \`binary\`."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run binary and catch errors with handler"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchReturn"
fnMarker="catchreturn"
foundNames=([0]="argument" [1]="requires")
line="284"
rawComment="Run binary and catch errors with handler"$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: binary ... - Executable. Required. Any arguments are passed to \`binary\`."$'\n'"Requires: returnArgument"$'\n'""$'\n'""
requires="returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="a07159f0d529eb650133ee48b457cb1ccff3f0d5"
sourceLine="284"
summary="Run binary and catch errors with handler"
summaryComputed="true"
usage="catchReturn handler binary ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchReturn'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler     '$'\e''[[(value)]mFunction. Required. Error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mbinary ...  '$'\e''[[(value)]mExecutable. Required. Any arguments are passed to '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Run binary and catch errors with handler'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: catchReturn handler binary ...'$'\n'''$'\n''    handler     Function. Required. Error handler.'$'\n''    binary ...  Executable. Required. Any arguments are passed to binary.'$'\n'''$'\n''Run binary and catch errors with handler'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar.md"
