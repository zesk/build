#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"url ... - String. URL. Required. A Uniform Resource Locator"$'\n'""
base="url.sh"
description="Checks if a URL is syntactically valid - solely a text check."$'\n'""
file="bin/build/tools/url.sh"
fn="urlValid"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
rawComment="Summary: Is a URL valid?"$'\n'"Checks if a URL is syntactically valid - solely a text check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url ... - String. URL. Required. A Uniform Resource Locator"$'\n'"Return Code: 0 - all URLs passed in are valid"$'\n'"Return Code: 1 - at least one URL passed in is not a valid URL"$'\n'""$'\n'""
return_code="0 - all URLs passed in are valid"$'\n'"1 - at least one URL passed in is not a valid URL"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="03de01449586d23f1ef8786eecbe5543530200e0"
summary="Is a URL valid?"$'\n'""
usage="urlValid [ --help ] url ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlValid'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl ...  '$'\e''[[(value)]mString. URL. Required. A Uniform Resource Locator'$'\e''[[(reset)]m'$'\n'''$'\n''Checks if a URL is syntactically valid - solely a text check.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - all URLs passed in are valid'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - at least one URL passed in is not a valid URL'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlValid [ --help ] url ...'$'\n'''$'\n''    --help   Flag. Optional. Display this help.'$'\n''    url ...  String. URL. Required. A Uniform Resource Locator'$'\n'''$'\n''Checks if a URL is syntactically valid - solely a text check.'$'\n'''$'\n''Return codes:'$'\n''- 0 - all URLs passed in are valid'$'\n''- 1 - at least one URL passed in is not a valid URL'$'\n'''
