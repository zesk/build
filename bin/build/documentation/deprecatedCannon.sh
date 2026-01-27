#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="--path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'"findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"search - String. Required. String to search for"$'\n'"replace - EmptyString. Required. Replacement string."$'\n'"extraCannonArguments - Arguments. Optional. Any additional arguments are passed to \`cannon\`."$'\n'""
base="deprecated-tools.sh"
description="No documentation for \`deprecatedCannon\`."$'\n'""
file="bin/build/tools/deprecated-tools.sh"
foundNames=([0]="argument")
rawComment="Argument: --path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'"Argument: findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"Argument: search - String. Required. String to search for"$'\n'"Argument: replace - EmptyString. Required. Replacement string."$'\n'"Argument: extraCannonArguments - Arguments. Optional. Any additional arguments are passed to \`cannon\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceModified="1769063211"
summary="undocumented"
usage="deprecatedCannon [ --path cannonPath ] findArgumentFunction search replace [ extraCannonArguments ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeprecatedCannon'$'\e''[0m '$'\e''[[(blue)]m[ --path cannonPath ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfindArgumentFunction'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msearch'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mreplace'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ extraCannonArguments ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--path cannonPath     '$'\e''[[(value)]mDirectory. Optional. Run cannon operation starting in this directory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfindArgumentFunction  '$'\e''[[(value)]mFunction. Required. Find arguments (for '$'\e''[[(code)]mfind'$'\e''[[(reset)]m) for cannon.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msearch                '$'\e''[[(value)]mString. Required. String to search for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mreplace               '$'\e''[[(value)]mEmptyString. Required. Replacement string.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mextraCannonArguments  '$'\e''[[(value)]mArguments. Optional. Any additional arguments are passed to '$'\e''[[(code)]mcannon'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]mdeprecatedCannon'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedCannon [ --path cannonPath ] findArgumentFunction search replace [ extraCannonArguments ]'$'\n'''$'\n''    --path cannonPath     Directory. Optional. Run cannon operation starting in this directory.'$'\n''    findArgumentFunction  Function. Required. Find arguments (for find) for cannon.'$'\n''    search                String. Required. String to search for'$'\n''    replace               EmptyString. Required. Replacement string.'$'\n''    extraCannonArguments  Arguments. Optional. Any additional arguments are passed to cannon.'$'\n'''$'\n''No documentation for deprecatedCannon.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.564
