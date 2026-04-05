#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-05
# shellcheck disable=SC2034
argument="functionName - String. Required. Function which should be called somewhere within a file."$'\n'"file - File. Required. File to search for function handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Show function handler in files"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashShowUsage"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Show function handler in files"$'\n'"Argument: functionName - String. Required. Function which should be called somewhere within a file."$'\n'"Argument: file - File. Required. File to search for function handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Function is used within the file"$'\n'"Return Code: 1 - Function is *not* used within the file"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'"Requires: throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""$'\n'""
requires="throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""
return_code="0 - Function is used within the file"$'\n'"1 - Function is *not* used within the file"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="286d8187414ff4bf8505a905b49ba4ca2b627ae9"
summary="Show function handler in files"
summaryComputed="true"
usage="bashShowUsage functionName file [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashShowUsage'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. Function which should be called somewhere within a file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile          '$'\e''[[(value)]mFile. Required. File to search for function handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Show function handler in files'$'\n''This check is simplistic and does not verify actual coverage or code paths.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Function is used within the file'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Function is '$'\e''[[(cyan)]mnot'$'\e''[[(reset)]m used within the file'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashShowUsage functionName file [ --help ]'$'\n'''$'\n''    functionName  String. Required. Function which should be called somewhere within a file.'$'\n''    file          File. Required. File to search for function handler.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Show function handler in files'$'\n''This check is simplistic and does not verify actual coverage or code paths.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Function is used within the file'$'\n''- 1 - Function is not used within the file'$'\n'''
