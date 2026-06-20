#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'style - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.\n-- - Flag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.\n--index - Flag. Optional. Show the index of each item before with a colon. `0:first 1:second` etc.\n--count - Flag. Optional. Show the count of items in the list after the list is generated.\n'
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Runs the following command on each subsequent argument for formatting\nAlso supports formatting input lines instead (on the same line)\n\n'
descriptionLineCount="3"
example=$'    decorate each code -- "$@"\n'
file="bin/build/tools/decorate/core.sh"
fn="decorate each"
fnMarker="__decorateextensioneach"
foundNames=([0]="fn" [1]="example" [2]="requires" [3]="argument")
line="262"
original="__decorateExtensionEach"
rawComment=$'fn: decorate each\nRuns the following command on each subsequent argument for formatting\nAlso supports formatting input lines instead (on the same line)\nExample:     decorate each code -- "$@"\nRequires: decorate printf\nArgument: style - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.\nArgument: -- - Flag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.\nArgument: --index - Flag. Optional. Show the index of each item before with a colon. `0:first 1:second` etc.\nArgument: --count - Flag. Optional. Show the count of items in the list after the list is generated.\n\n'
requires=$'decorate printf\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="e6992e7d5127060733a36794bcafe7410442140a"
sourceLine="262"
summary="Runs the following command on each subsequent argument for formatting"
summaryComputed="true"
usage="decorate each style [ -- ] [ --index ] [ --count ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorate each'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstyle'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(blue)]m[ --index ]'$'\e''[0m '$'\e''[[(blue)]m[ --count ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstyle    '$'\e''[[(value)]mCommaDelimitedList. Required. Style arguments passed directly to decorate for each item.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--       '$'\e''[[(value)]mFlag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--index  '$'\e''[[(value)]mFlag. Optional. Show the index of each item before with a colon. '$'\e''[[(code)]m0:first 1:second'$'\e''[[(reset)]m etc.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--count  '$'\e''[[(value)]mFlag. Optional. Show the count of items in the list after the list is generated.'$'\e''[[(reset)]m'$'\n'''$'\n''Runs the following command on each subsequent argument for formatting'$'\n''Also supports formatting input lines instead (on the same line)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    decorate each code -- "$@"'
# shellcheck disable=SC2016
helpPlain='Usage: decorate each style [ -- ] [ --index ] [ --count ]'$'\n'''$'\n''    style    CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.'$'\n''    --       Flag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.'$'\n''    --index  Flag. Optional. Show the index of each item before with a colon. 0:first 1:second etc.'$'\n''    --count  Flag. Optional. Show the count of items in the list after the list is generated.'$'\n'''$'\n''Runs the following command on each subsequent argument for formatting'$'\n''Also supports formatting input lines instead (on the same line)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    decorate each code -- "$@"'
documentationPath="documentation/source/tools/decorate.md"
