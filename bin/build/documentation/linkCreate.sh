#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="target - Exists. File. Source file name or path."$'\n'"linkName - String. Required. Link short name, created next to \`target\`."$'\n'""
base="file.sh"
description="Create a link"$'\n'""
file="bin/build/tools/file.sh"
foundNames=([0]="argument")
rawComment="Create a link"$'\n'"Argument: target - Exists. File. Source file name or path."$'\n'"Argument: linkName - String. Required. Link short name, created next to \`target\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Create a link"
usage="linkCreate [ target ] linkName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlinkCreate'$'\e''[0m '$'\e''[[(blue)]m[ target ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlinkName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtarget    '$'\e''[[(value)]mExists. File. Source file name or path.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlinkName  '$'\e''[[(value)]mString. Required. Link short name, created next to '$'\e''[[(code)]mtarget'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Create a link'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: linkCreate [ target ] linkName'$'\n'''$'\n''    target    Exists. File. Source file name or path.'$'\n''    linkName  String. Required. Link short name, created next to target.'$'\n'''$'\n''Create a link'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.613
