#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"url ... - String. URL. Required. A Uniform Resource Locator"$'\n'""
base="url.sh"
description="Checks if a URL is valid"$'\n'""
exitCode="0"
file="bin/build/tools/url.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Checks if a URL is valid"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url ... - String. URL. Required. A Uniform Resource Locator"$'\n'"Return Code: 0 - all URLs passed in are valid"$'\n'"Return Code: 1 - at least one URL passed in is not a valid URL"$'\n'""$'\n'""
return_code="0 - all URLs passed in are valid"$'\n'"1 - at least one URL passed in is not a valid URL"$'\n'""
sourceModified="1769184734"
summary="Checks if a URL is valid"
usage="urlValid [ --help ] url ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]murlValid'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]murl ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help   '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]murl ...  '$'\e''[[value]mString. URL. Required. A Uniform Resource Locator'$'\e''[[reset]m'$'\n'''$'\n''Checks if a URL is valid'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - all URLs passed in are valid'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - at least one URL passed in is not a valid URL'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlValid [ --help ] url ...'$'\n'''$'\n''    --help   Flag. Optional. Display this help.'$'\n''    url ...  String. URL. Required. A Uniform Resource Locator'$'\n'''$'\n''Checks if a URL is valid'$'\n'''$'\n''Return codes:'$'\n''- 0 - all URLs passed in are valid'$'\n''- 1 - at least one URL passed in is not a valid URL'$'\n'''
