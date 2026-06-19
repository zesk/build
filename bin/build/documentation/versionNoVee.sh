#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="version.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Strip leading `v` from version tags. Useful when you standardize on the non-`v` versions or wish to sort without the `v`.\n\nTake one or more versions and strip the leading `v`\n\n'
descriptionLineCount="4"
file="bin/build/tools/version.sh"
fn="versionNoVee"
fnMarker="versionnovee"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout")
line="42"
rawComment=$'Summary: Remove `v` from versions\nStrip leading `v` from version tags. Useful when you standardize on the non-`v` versions or wish to sort without the `v`.\nArgument: --help - Flag. Optional. Display this help.\nTake one or more versions and strip the leading `v`\nstdin: Versions containing a preceding `v` character (optionally)\nstdout: Versions with the initial `v` (if it exists) removed\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/version.sh"
sourceHash="c99a643316ae012c003405614babad883b2035e7"
sourceLine="42"
stdin=$'Versions containing a preceding `v` character (optionally)\n'
stdout=$'Versions with the initial `v` (if it exists) removed\n'
summary="Remove \`v\` from versions"
summaryComputed=""
usage="versionNoVee [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mversionNoVee'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Strip leading '$'\e''[[(code)]mv'$'\e''[[(reset)]m from version tags. Useful when you standardize on the non-'$'\e''[[(code)]mv'$'\e''[[(reset)]m versions or wish to sort without the '$'\e''[[(code)]mv'$'\e''[[(reset)]m.'$'\n'''$'\n''Take one or more versions and strip the leading '$'\e''[[(code)]mv'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Versions containing a preceding '$'\e''[[(code)]mv'$'\e''[[(reset)]m character (optionally)'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Versions with the initial '$'\e''[[(code)]mv'$'\e''[[(reset)]m (if it exists) removed'
# shellcheck disable=SC2016
helpPlain='Usage: versionNoVee [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Strip leading v from version tags. Useful when you standardize on the non-v versions or wish to sort without the v.'$'\n'''$'\n''Take one or more versions and strip the leading v'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Versions containing a preceding v character (optionally)'$'\n'''$'\n''Writes to stdout:'$'\n''Versions with the initial v (if it exists) removed'
documentationPath="documentation/source/tools/version.md"
