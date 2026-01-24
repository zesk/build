#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--exec - Executable. Optional. If not supplied uses \`urlOpen\`."$'\n'""
base="url.sh"
description="Open URLs which appear in a stream"$'\n'"(but continue to output the stream)"$'\n'""
exitCode="0"
file="bin/build/tools/url.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Open URLs which appear in a stream"$'\n'"(but continue to output the stream)"$'\n'"Argument: --exec - Executable. Optional. If not supplied uses \`urlOpen\`."$'\n'"stdin: text"$'\n'"stdout: text"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
stdin="text"$'\n'""
stdout="text"$'\n'""
summary="Open URLs which appear in a stream"
usage="urlOpener [ --exec ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]murlOpener'$'\e''[0m '$'\e''[[blue]m[ --exec ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--exec  '$'\e''[[value]mExecutable. Optional. If not supplied uses '$'\e''[[code]murlOpen'$'\e''[[reset]m.'$'\e''[[reset]m'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''(but continue to output the stream)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''text'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''text'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlOpener [ --exec ]'$'\n'''$'\n''    --exec  Executable. Optional. If not supplied uses urlOpen.'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''(but continue to output the stream)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text'$'\n'''$'\n''Writes to stdout:'$'\n''text'$'\n'''
