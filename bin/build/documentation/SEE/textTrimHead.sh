#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Removes any blank lines from the beginning of a stream\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="textTrimHead"
fnMarker="texttrimhead"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="249"
rawComment=$'Removes any blank lines from the beginning of a stream\nArgument: --help - Flag. Optional. Display this help.\nstdin: Reads lines from stdin until EOF\nstdout: Outputs modified lines\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="249"
stdin=$'Reads lines from stdin until EOF\n'
stdout=$'Outputs modified lines\n'
summary="Removes any blank lines from the beginning of a stream"
summaryComputed="true"
usage="textTrimHead [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextTrimHead'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Removes any blank lines from the beginning of a stream'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Outputs modified lines'
# shellcheck disable=SC2016
helpPlain='Usage: textTrimHead [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Removes any blank lines from the beginning of a stream'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs modified lines'
documentationPath="documentation/source/tools/text.md"
