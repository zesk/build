#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="script - File. Required. Bash script to fetch requires tokens from."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Gets a list of the \`Requires:\` comments in a bash file"$'\n'"Returns a unique list of tokens"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/bash.sh"
fn="bashGetRequires"
fnMarker="bashgetrequires"
foundNames=([0]="argument")
line="44"
rawComment="Argument: script - File. Required. Bash script to fetch requires tokens from."$'\n'"Gets a list of the \`Requires:\` comments in a bash file"$'\n'"Returns a unique list of tokens"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="44"
summary="Gets a list of the \`Requires:\` comments in a bash"
summaryComputed="true"
usage="bashGetRequires script"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashGetRequires'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mscript'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mscript  '$'\e''[[(value)]mFile. Required. Bash script to fetch requires tokens from.'$'\e''[[(reset)]m'$'\n'''$'\n''Gets a list of the '$'\e''[[(code)]mRequires:'$'\e''[[(reset)]m comments in a bash file'$'\n''Returns a unique list of tokens'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashGetRequires script'$'\n'''$'\n''    script  File. Required. Bash script to fetch requires tokens from.'$'\n'''$'\n''Gets a list of the Requires: comments in a bash file'$'\n''Returns a unique list of tokens'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
