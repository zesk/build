#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'ignorePattern - Optional. String. Specify a grep pattern to ignore; allows you to ignore current version\n--help - Flag. Optional. Display this help.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the last reported version.\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitVersionLast"
fnMarker="gitversionlast"
foundNames=([0]="argument")
line="164"
rawComment=$'Get the last reported version.\nArgument: ignorePattern - Optional. String. Specify a grep pattern to ignore; allows you to ignore current version\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="164"
summary="Get the last reported version."
summaryComputed="true"
usage="gitVersionLast [ ignorePattern ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitVersionLast'$'\e''[0m '$'\e''[[(blue)]m[ ignorePattern ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mignorePattern  '$'\e''[[(value)]mOptional. String. Specify a grep pattern to ignore; allows you to ignore current version'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the last reported version.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitVersionLast [ ignorePattern ] [ --help ]'$'\n'''$'\n''    ignorePattern  Optional. String. Specify a grep pattern to ignore; allows you to ignore current version'$'\n''    --help         Flag. Optional. Display this help.'$'\n'''$'\n''Get the last reported version.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
