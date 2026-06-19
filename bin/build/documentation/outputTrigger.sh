#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Help\n--verbose - Flag. Optional. Verbose messages when no errors exist.\n--name name - String. Optional. Name for verbose mode.\nmessage ... - Optional. Optional. Message for verbose mode.\n'
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Check output for content and trigger environment error if found\n\n'
descriptionLineCount="2"
example=$'    source "$include" > >(outputTrigger source "$include") || return $?\n'
file="bin/build/tools/debug.sh"
fn="outputTrigger"
fnMarker="outputtrigger"
foundNames=([0]="argument" [1]="return_code" [2]="stdin" [3]="stdout" [4]="example")
line="528"
rawComment=$'Check output for content and trigger environment error if found\nArgument: --help - Help\nArgument: --verbose - Flag. Optional. Verbose messages when no errors exist.\nArgument: --name name - String. Optional. Name for verbose mode.\nArgument: message ... - Optional. Optional. Message for verbose mode.\nReturn Code: 0 - If no content is read from `stdin`\nReturn Code: 1 - If any content is read from `stdin` (and output to `stdout`)\nReturn Code: 2 - Argument error\nstdin: Any content\nstdout: Same content\nExample:     source "$include" > >(outputTrigger source "$include") || return $?\n\n'
return_code=$'0 - If no content is read from `stdin`\n1 - If any content is read from `stdin` (and output to `stdout`)\n2 - Argument error\n'
sourceFile="bin/build/tools/debug.sh"
sourceHash="c698b75c5757732f1b8a82693f110a2be335611f"
sourceLine="528"
stdin=$'Any content\n'
stdout=$'Same content\n'
summary="Check output for content and trigger environment error if found"
summaryComputed="true"
usage="outputTrigger [ --help ] [ --verbose ] [ --name name ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]moutputTrigger'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --name name ]'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mHelp'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose    '$'\e''[[(value)]mFlag. Optional. Verbose messages when no errors exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--name name  '$'\e''[[(value)]mString. Optional. Name for verbose mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mOptional. Optional. Message for verbose mode.'$'\e''[[(reset)]m'$'\n'''$'\n''Check output for content and trigger environment error if found'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If no content is read from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If any content is read from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m (and output to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m)'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Any content'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Same content'$'\n'''$'\n''Example:'$'\n''    source "$include" > >(outputTrigger source "$include") || return $?'
# shellcheck disable=SC2016
helpPlain='Usage: outputTrigger [ --help ] [ --verbose ] [ --name name ] [ message ... ]'$'\n'''$'\n''    --help       Help'$'\n''    --verbose    Flag. Optional. Verbose messages when no errors exist.'$'\n''    --name name  String. Optional. Name for verbose mode.'$'\n''    message ...  Optional. Optional. Message for verbose mode.'$'\n'''$'\n''Check output for content and trigger environment error if found'$'\n'''$'\n''Return codes:'$'\n''- 0 - If no content is read from stdin'$'\n''- 1 - If any content is read from stdin (and output to stdout)'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Any content'$'\n'''$'\n''Writes to stdout:'$'\n''Same content'$'\n'''$'\n''Example:'$'\n''    source "$include" > >(outputTrigger source "$include") || return $?'
documentationPath="documentation/source/tools/debug.md"
