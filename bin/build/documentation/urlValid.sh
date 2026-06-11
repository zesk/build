#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nurl ... - String. URL. Required. A Uniform Resource Locator\n'
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Checks if a URL is syntactically valid - solely a text check.\n\n'
descriptionLineCount="2"
file="bin/build/tools/url.sh"
fn="urlValid"
fnMarker="urlvalid"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="263"
rawComment=$'Summary: Is a URL valid?\nChecks if a URL is syntactically valid - solely a text check.\nArgument: --help - Flag. Optional. Display this help.\nArgument: url ... - String. URL. Required. A Uniform Resource Locator\nReturn Code: 0 - all URLs passed in are valid\nReturn Code: 1 - at least one URL passed in is not a valid URL\n\n'
return_code=$'0 - all URLs passed in are valid\n1 - at least one URL passed in is not a valid URL\n'
sourceFile="bin/build/tools/url.sh"
sourceHash="5888613ceea13bebc1d11eb2f7336dca1a856d50"
sourceLine="263"
summary="Is a URL valid?"
summaryComputed=""
usage="urlValid [ --help ] url ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlValid'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl ...  '$'\e''[[(value)]mString. URL. Required. A Uniform Resource Locator'$'\e''[[(reset)]m'$'\n'''$'\n''Checks if a URL is syntactically valid - solely a text check.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - all URLs passed in are valid'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - at least one URL passed in is not a valid URL'
# shellcheck disable=SC2016
helpPlain='Usage: urlValid [ --help ] url ...'$'\n'''$'\n''    --help   Flag. Optional. Display this help.'$'\n''    url ...  String. URL. Required. A Uniform Resource Locator'$'\n'''$'\n''Checks if a URL is syntactically valid - solely a text check.'$'\n'''$'\n''Return codes:'$'\n''- 0 - all URLs passed in are valid'$'\n''- 1 - at least one URL passed in is not a valid URL'
documentationPath="documentation/source/tools/url.md"
