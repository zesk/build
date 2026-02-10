#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="path - String. Output a json path separated by dots."$'\n'""
base="json.sh"
description="Generate a path for a JSON structure for use in \`jq\` queries"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/json.sh"
foundNames=([0]="summary" [1]="argument")
rawComment="Summary: Generate \`jq\` paths"$'\n'"Generate a path for a JSON structure for use in \`jq\` queries"$'\n'"Argument: path - String. Output a json path separated by dots."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="3505d1bfdcea59364bfe55887392a665d22cea11"
summary="Generate \`jq\` paths"$'\n'""
usage="jsonPath [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonPath'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpath  '$'\e''[[(value)]mString. Output a json path separated by dots.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate a path for a JSON structure for use in '$'\e''[[(code)]mjq'$'\e''[[(reset)]m queries'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: jsonPath [ path ]'$'\n'''$'\n''    path  String. Output a json path separated by dots.'$'\n'''$'\n''Generate a path for a JSON structure for use in jq queries'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
