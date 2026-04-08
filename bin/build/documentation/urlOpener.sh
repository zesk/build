#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="--exec - Executable. Optional. If not supplied uses \`urlOpen\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="url.sh"
description="Open URLs which appear in a stream"$'\n'"(but continue to output the stream)"$'\n'""
file="bin/build/tools/url.sh"
fn="urlOpener"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout")
rawComment="Summary: URL opener stream filter"$'\n'"Open URLs which appear in a stream"$'\n'"(but continue to output the stream)"$'\n'"Argument: --exec - Executable. Optional. If not supplied uses \`urlOpen\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: text"$'\n'"stdout: text"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="03de01449586d23f1ef8786eecbe5543530200e0"
stdin="text"$'\n'""
stdout="text"$'\n'""
summary="URL opener stream filter"$'\n'""
usage="urlOpener [ --exec ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlOpener'$'\e''[0m '$'\e''[[(blue)]m[ --exec ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--exec  '$'\e''[[(value)]mExecutable. Optional. If not supplied uses '$'\e''[[(code)]murlOpen'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''(but continue to output the stream)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''text'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlOpener [ --exec ] [ --help ]'$'\n'''$'\n''    --exec  Executable. Optional. If not supplied uses urlOpen.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''(but continue to output the stream)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text'$'\n'''$'\n''Writes to stdout:'$'\n''text'$'\n'''
