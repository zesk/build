#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="--help - Help"$'\n'"--verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"--name name - String. Optional. Name for verbose mode."$'\n'"message ... - Optional. Optional. Message for verbose mode."$'\n'""
base="debug.sh"
description="Check output for content and trigger environment error if found"$'\n'""
example="    source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="argument" [1]="return_code" [2]="stdin" [3]="stdout" [4]="example")
rawComment="Check output for content and trigger environment error if found"$'\n'"Argument: --help - Help"$'\n'"Argument: --verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"Argument: --name name - String. Optional. Name for verbose mode."$'\n'"Argument: message ... - Optional. Optional. Message for verbose mode."$'\n'"Return Code: 0 - If no content is read from \`stdin\`"$'\n'"Return Code: 1 - If any content is read from \`stdin\` (and output to \`stdout\`)"$'\n'"Return Code: 2 - Argument error"$'\n'"stdin: Any content"$'\n'"stdout: Same content"$'\n'"Example:     source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""$'\n'""
return_code="0 - If no content is read from \`stdin\`"$'\n'"1 - If any content is read from \`stdin\` (and output to \`stdout\`)"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="a904ac31e55b57261f1d3e3fb6c67407a1f69618"
stdin="Any content"$'\n'""
stdout="Same content"$'\n'""
summary="Check output for content and trigger environment error if found"
summaryComputed="true"
usage="outputTrigger [ --help ] [ --verbose ] [ --name name ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]moutputTrigger'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --name name ]'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mHelp'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose    '$'\e''[[(value)]mFlag. Optional. Verbose messages when no errors exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--name name  '$'\e''[[(value)]mString. Optional. Name for verbose mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mOptional. Optional. Message for verbose mode.'$'\e''[[(reset)]m'$'\n'''$'\n''Check output for content and trigger environment error if found'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If no content is read from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If any content is read from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m (and output to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m)'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Any content'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Same content'$'\n'''$'\n''Example:'$'\n''    source "$include" > >(outputTrigger source "$include") || return $?'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: outputTrigger [ --help ] [ --verbose ] [ --name name ] [ message ... ]'$'\n'''$'\n''    --help       Help'$'\n''    --verbose    Flag. Optional. Verbose messages when no errors exist.'$'\n''    --name name  String. Optional. Name for verbose mode.'$'\n''    message ...  Optional. Optional. Message for verbose mode.'$'\n'''$'\n''Check output for content and trigger environment error if found'$'\n'''$'\n''Return codes:'$'\n''- 0 - If no content is read from stdin'$'\n''- 1 - If any content is read from stdin (and output to stdout)'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Any content'$'\n'''$'\n''Writes to stdout:'$'\n''Same content'$'\n'''$'\n''Example:'$'\n''    source "$include" > >(outputTrigger source "$include") || return $?'$'\n'''
