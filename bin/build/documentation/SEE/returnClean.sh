#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'exitCode - Integer. Required. Exit code to return.\nitem - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Delete files or directories and return the same exit code passed in.\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnClean"
fnMarker="returnclean"
foundNames=([0]="argument" [1]="requires" [2]="group")
group=$'Sugar\n'
line="101"
rawComment=$'Delete files or directories and return the same exit code passed in.\nArgument: exitCode - Integer. Required. Exit code to return.\nArgument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.\nRequires: isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument helpArgument\nGroup: Sugar\n\n'
requires=$'isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument helpArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="101"
summary="Delete files or directories and return the same exit code"
summaryComputed="true"
usage="returnClean exitCode [ item ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnClean'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mexitCode'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ item ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mexitCode  '$'\e''[[(value)]mInteger. Required. Exit code to return.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mitem      '$'\e''[[(value)]mExists. Optional. One or more files or folders to delete, failures are logged to stderr.'$'\e''[[(reset)]m'$'\n'''$'\n''Delete files or directories and return the same exit code passed in.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: returnClean exitCode [ item ]'$'\n'''$'\n''    exitCode  Integer. Required. Exit code to return.'$'\n''    item      Exists. Optional. One or more files or folders to delete, failures are logged to stderr.'$'\n'''$'\n''Delete files or directories and return the same exit code passed in.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar-core.md"
