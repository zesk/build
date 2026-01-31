#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="deprecated-tools.sh"
description="Find files which match a token or tokens"$'\n'"Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)"$'\n'"Return Code: 1 - Search tokens were not found in any file (which matches find arguments)"$'\n'"Argument: findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"Argument: search - String. Required. String to search for (one or more)"$'\n'"Argument: --path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'"See: buildHome"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
foundNames=()
rawComment="Find files which match a token or tokens"$'\n'"Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)"$'\n'"Return Code: 1 - Search tokens were not found in any file (which matches find arguments)"$'\n'"Argument: findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"Argument: search - String. Required. String to search for (one or more)"$'\n'"Argument: --path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'"See: buildHome"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="f6ff1d0254473f216c6361ebc735edfbb7a60b50"
summary="Find files which match a token or tokens"
usage="deprecatedFind"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeprecatedFind'$'\e''[0m'$'\n'''$'\n''Find files which match a token or tokens'$'\n''Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)'$'\n''Return Code: 1 - Search tokens were not found in any file (which matches find arguments)'$'\n''Argument: findArgumentFunction - Function. Required. Find arguments (for '$'\e''[[(code)]mfind'$'\e''[[(reset)]m) for cannon.'$'\n''Argument: search - String. Required. String to search for (one or more)'$'\n''Argument: --path cannonPath - Directory. Optional. Run cannon operation starting in this directory.'$'\n''See: buildHome'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedFind'$'\n'''$'\n''Find files which match a token or tokens'$'\n''Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)'$'\n''Return Code: 1 - Search tokens were not found in any file (which matches find arguments)'$'\n''Argument: findArgumentFunction - Function. Required. Find arguments (for find) for cannon.'$'\n''Argument: search - String. Required. String to search for (one or more)'$'\n''Argument: --path cannonPath - Directory. Optional. Run cannon operation starting in this directory.'$'\n''See: buildHome'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.449
