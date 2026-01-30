#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="path - String. Output a json path separated by dots."$'\n'""
base="json.sh"
description="Generate a path for a JSON structure for use in \`jq\` queries"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/json.sh"
foundNames=([0]="summary" [1]="argument")
rawComment="Summary: Generate \`jq\` paths"$'\n'"Generate a path for a JSON structure for use in \`jq\` queries"$'\n'"Argument: path - String. Output a json path separated by dots."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="9eca986222c45a4744245dec0f8641ae55ec29b9"
summary="Generate \`jq\` paths"$'\n'""
usage="jsonPath [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonPath'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpath  '$'\e''[[(value)]mString. Output a json path separated by dots.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate a path for a JSON structure for use in '$'\e''[[(code)]mjq'$'\e''[[(reset)]m queries'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mjsonPath [[(blue)]m[ path ]'$'\n'''$'\n''    [[(blue)]mpath  [[(value)]mString. Output a json path separated by dots.[[(reset)]m'$'\n'''$'\n''Generate a path for a JSON structure for use in [[(code)]mjq[[(reset)]m queries'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''
# elapsed 2.314
