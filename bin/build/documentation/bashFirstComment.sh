#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Extracts the first comment from a stream.\nExcludes lines containing the following tokens:\n\n'
descriptionLineCount="3"
file="bin/build/tools/bash.sh"
fn="bashFirstComment"
fnMarker="bashfirstcomment"
foundNames=([0]="summary" [1]="argument" [2]="requires")
line="588"
rawComment=$'Summary: Extract first comment from a stream\nExtracts the first comment from a stream.\nExcludes lines containing the following tokens:\nArgument: --help - Flag. Optional. Display this help.\nRequires: fileReverseLines sed cut grep convertValue\n\n'
requires=$'fileReverseLines sed cut grep convertValue\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="44e2d7bb2f580d31f81f1caec019ec7815f1d160"
sourceLine="588"
summary="Extract first comment from a stream"
summaryComputed=""
usage="bashFirstComment [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFirstComment'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extracts the first comment from a stream.'$'\n''Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashFirstComment [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Extracts the first comment from a stream.'$'\n''Excludes lines containing the following tokens:'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
