#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-28
# shellcheck disable=SC2034
argument="target - Exists. File. Source file name or path."$'\n'"linkName - String. Required. Link short name, created next to \`target\`."$'\n'""
base="file.sh"
description="Create a link"$'\n'""
file="bin/build/tools/file.sh"
fn="linkCreate"
foundNames=([0]="argument")
line="730"
lowerFn="linkcreate"
rawComment="Create a link"$'\n'"Argument: target - Exists. File. Source file name or path."$'\n'"Argument: linkName - String. Required. Link short name, created next to \`target\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="730"
summary="Create a link"
summaryComputed="true"
usage="linkCreate [ target ] linkName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlinkCreate'$'\e''[0m '$'\e''[[(blue)]m[ target ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlinkName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtarget    '$'\e''[[(value)]mExists. File. Source file name or path.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlinkName  '$'\e''[[(value)]mString. Required. Link short name, created next to '$'\e''[[(code)]mtarget'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Create a link'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: linkCreate [ target ] linkName'$'\n'''$'\n''    target    Exists. File. Source file name or path.'$'\n''    linkName  String. Required. Link short name, created next to target.'$'\n'''$'\n''Create a link'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/file.md"
