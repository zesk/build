#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-11
# shellcheck disable=SC2034
argument=$'--exec - Executable. Optional. If not supplied uses `urlOpen`.\n--help - Flag. Optional. Display this help.\n'
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Open URLs which appear in a stream\n(but continue to output the stream)\n\n'
descriptionLineCount="3"
file="bin/build/tools/url.sh"
fn="urlOpener"
fnMarker="urlopener"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout")
line="295"
rawComment=$'Summary: URL opener stream filter\nOpen URLs which appear in a stream\n(but continue to output the stream)\nArgument: --exec - Executable. Optional. If not supplied uses `urlOpen`.\nArgument: --help - Flag. Optional. Display this help.\nstdin: text\nstdout: text\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/url.sh"
sourceHash="5888613ceea13bebc1d11eb2f7336dca1a856d50"
sourceLine="295"
stdin=$'text\n'
stdout=$'text\n'
summary="URL opener stream filter"
summaryComputed=""
usage="urlOpener [ --exec ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlOpener'$'\e''[0m '$'\e''[[(blue)]m[ --exec ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--exec  '$'\e''[[(value)]mExecutable. Optional. If not supplied uses '$'\e''[[(code)]murlOpen'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''(but continue to output the stream)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''text'
# shellcheck disable=SC2016
helpPlain='Usage: urlOpener [ --exec ] [ --help ]'$'\n'''$'\n''    --exec  Executable. Optional. If not supplied uses urlOpen.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''(but continue to output the stream)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text'$'\n'''$'\n''Writes to stdout:'$'\n''text'
documentationPath="documentation/source/tools/url.md"
