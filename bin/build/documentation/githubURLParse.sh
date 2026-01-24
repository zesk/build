#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/github.sh"
argument="url - URL. Required. URL to parse."$'\n'""
base="github.sh"
description="Parse a GitHub URL and return the owner and project name"$'\n'""
exitCode="0"
file="bin/build/tools/github.sh"
foundNames=([0]="argument")
rawComment="Parse a GitHub URL and return the owner and project name"$'\n'"Argument: url - URL. Required. URL to parse."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceModified="1769111847"
summary="Parse a GitHub URL and return the owner and project"
usage="githubURLParse url"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgithubURLParse'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]murl'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]murl  '$'\e''[[value]mURL. Required. URL to parse.'$'\e''[[reset]m'$'\n'''$'\n''Parse a GitHub URL and return the owner and project name'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: githubURLParse url'$'\n'''$'\n''    url  URL. Required. URL to parse.'$'\n'''$'\n''Parse a GitHub URL and return the owner and project name'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
