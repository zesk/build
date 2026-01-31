#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Convert text to uppercase"$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: text - EmptyString. Required. text to convert to uppercase"$'\n'"stdout: \`String\`. The uppercase version of the \`text\`."$'\n'"Requires: tr"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Convert text to uppercase"$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: text - EmptyString. Required. text to convert to uppercase"$'\n'"stdout: \`String\`. The uppercase version of the \`text\`."$'\n'"Requires: tr"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Convert text to uppercase"
usage="uppercase"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]muppercase'$'\e''[0m'$'\n'''$'\n''Convert text to uppercase'$'\n''Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: text - EmptyString. Required. text to convert to uppercase'$'\n''stdout: '$'\e''[[(code)]mString'$'\e''[[(reset)]m. The uppercase version of the '$'\e''[[(code)]mtext'$'\e''[[(reset)]m.'$'\n''Requires: tr'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: uppercase'$'\n'''$'\n''Convert text to uppercase'$'\n''Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: text - EmptyString. Required. text to convert to uppercase'$'\n''stdout: String. The uppercase version of the text.'$'\n''Requires: tr'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.515
