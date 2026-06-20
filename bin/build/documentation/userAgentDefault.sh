#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'A default user agent which looks more like a browser and less like a UNIX command-line tool (debatable)\n\n'
descriptionLineCount="2"
file="bin/build/tools/url.sh"
fn="userAgentDefault"
fnMarker="useragentdefault"
foundNames=([0]="summary" [1]="stdout" [2]="argument")
line="534"
original="userAgentDefault"
rawComment=$'Summary: Default user agent string for web agents\nA default user agent which looks more like a browser and less like a UNIX command-line tool (debatable)\nstdout: String\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/url.sh"
sourceHash="f32b7cbe9339aa8f7842cb180b43f028a41f69e6"
sourceLine="534"
stdout=$'String\n'
summary="Default user agent string for web agents"
summaryComputed=""
usage="userAgentDefault [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]muserAgentDefault'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''A default user agent which looks more like a browser and less like a UNIX command-line tool (debatable)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''String'
# shellcheck disable=SC2016
helpPlain='Usage: userAgentDefault [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''A default user agent which looks more like a browser and less like a UNIX command-line tool (debatable)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String'
documentationPath="documentation/source/tools/url.md"
