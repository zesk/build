#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--verbose - Flag. Optional. Be verbose about what the function is doing.\n--list - Flag. Optional. Show the list of what has changed since the first invocation.\n--profile - Flag. Optional. Mark the end of profile definitions.\n--developer - Flag. Optional. Mark the start of developer definitions.\n'
base="developer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'With no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred.\n\nIn general, you will add `{fn} --profile` at the end of your `.bashrc` file, and you will add `{fn} --developer` at the *start* of your `developer.sh` before you define anything.\n\n'
descriptionLineCount="4"
file="bin/build/tools/developer.sh"
fn="developerTrack"
fnMarker="developertrack"
foundNames=([0]="summary" [1]="argument" [2]="stdout")
line="102"
original="developerTrack"
rawComment=$'Summary: Track changes to the bash environment\nWith no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred.\nIn general, you will add `{fn} --profile` at the end of your `.bashrc` file, and you will add `{fn} --developer` at the *start* of your `developer.sh` before you define anything.\nArgument: --verbose - Flag. Optional. Be verbose about what the function is doing.\nArgument: --list - Flag. Optional. Show the list of what has changed since the first invocation.\nArgument: --profile - Flag. Optional. Mark the end of profile definitions.\nArgument: --developer - Flag. Optional. Mark the start of developer definitions.\nstdout: list of function|alias|environment\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/developer.sh"
sourceHash="cbbc092a821837875415856193f556aae0aabd6f"
sourceLine="102"
stdout=$'list of function|alias|environment\n'
summary="Track changes to the bash environment"
summaryComputed=""
usage="developerTrack [ --verbose ] [ --list ] [ --profile ] [ --developer ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeveloperTrack'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --list ]'$'\e''[0m '$'\e''[[(blue)]m[ --profile ]'$'\e''[0m '$'\e''[[(blue)]m[ --developer ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--verbose    '$'\e''[[(value)]mFlag. Optional. Be verbose about what the function is doing.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--list       '$'\e''[[(value)]mFlag. Optional. Show the list of what has changed since the first invocation.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--profile    '$'\e''[[(value)]mFlag. Optional. Mark the end of profile definitions.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--developer  '$'\e''[[(value)]mFlag. Optional. Mark the start of developer definitions.'$'\e''[[(reset)]m'$'\n'''$'\n''With no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred.'$'\n'''$'\n''In general, you will add '$'\e''[[(code)]mdeveloperTrack --profile'$'\e''[[(reset)]m at the end of your '$'\e''[[(code)]m.bashrc'$'\e''[[(reset)]m file, and you will add '$'\e''[[(code)]mdeveloperTrack --developer'$'\e''[[(reset)]m at the '$'\e''[[(cyan)]mstart'$'\e''[[(reset)]m of your '$'\e''[[(code)]mdeveloper.sh'$'\e''[[(reset)]m before you define anything.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''list of function|alias|environment'
# shellcheck disable=SC2016
helpPlain='Usage: developerTrack [ --verbose ] [ --list ] [ --profile ] [ --developer ]'$'\n'''$'\n''    --verbose    Flag. Optional. Be verbose about what the function is doing.'$'\n''    --list       Flag. Optional. Show the list of what has changed since the first invocation.'$'\n''    --profile    Flag. Optional. Mark the end of profile definitions.'$'\n''    --developer  Flag. Optional. Mark the start of developer definitions.'$'\n'''$'\n''With no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred.'$'\n'''$'\n''In general, you will add developerTrack --profile at the end of your .bashrc file, and you will add developerTrack --developer at the start of your developer.sh before you define anything.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''list of function|alias|environment'
documentationPath="documentation/source/tools/developer.md"
