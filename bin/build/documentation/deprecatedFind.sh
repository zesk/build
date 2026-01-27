#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"search - String. Required. String to search for (one or more)"$'\n'"--path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'""
base="deprecated-tools.sh"
description="Find files which match a token or tokens"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
foundNames=([0]="return_code" [1]="argument" [2]="see")
rawComment="Find files which match a token or tokens"$'\n'"Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)"$'\n'"Return Code: 1 - Search tokens were not found in any file (which matches find arguments)"$'\n'"Argument: findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"Argument: search - String. Required. String to search for (one or more)"$'\n'"Argument: --path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'"See: buildHome"$'\n'""$'\n'""
return_code="0 - One of the search tokens was found in a file (which matches find arguments)"$'\n'"1 - Search tokens were not found in any file (which matches find arguments)"$'\n'""
see="buildHome"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceModified="1769063211"
summary="Find files which match a token or tokens"
usage="deprecatedFind findArgumentFunction search [ --path cannonPath ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeprecatedFind'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfindArgumentFunction'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msearch'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --path cannonPath ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfindArgumentFunction  '$'\e''[[(value)]mFunction. Required. Find arguments (for '$'\e''[[(code)]mfind'$'\e''[[(reset)]m) for cannon.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msearch                '$'\e''[[(value)]mString. Required. String to search for (one or more)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--path cannonPath     '$'\e''[[(value)]mDirectory. Optional. Run cannon operation starting in this directory.'$'\e''[[(reset)]m'$'\n'''$'\n''Find files which match a token or tokens'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - One of the search tokens was found in a file (which matches find arguments)'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Search tokens were not found in any file (which matches find arguments)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedFind findArgumentFunction search [ --path cannonPath ]'$'\n'''$'\n''    findArgumentFunction  Function. Required. Find arguments (for find) for cannon.'$'\n''    search                String. Required. String to search for (one or more)'$'\n''    --path cannonPath     Directory. Optional. Run cannon operation starting in this directory.'$'\n'''$'\n''Find files which match a token or tokens'$'\n'''$'\n''Return codes:'$'\n''- 0 - One of the search tokens was found in a file (which matches find arguments)'$'\n''- 1 - Search tokens were not found in any file (which matches find arguments)'$'\n'''
# elapsed 0.641
