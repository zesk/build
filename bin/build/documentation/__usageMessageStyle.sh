#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'returnCode - UnsignedInteger. Required. Return code to use as the basis for styling output.\n'
base="install.sample.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Format arguments using the usage message return code to style output.\n- `0` - meaning no error, style is `info`\n- `1` - Environment error, style is `error`\n- `2` - Argument error, style is `red`\n- `*` - All additional errors, style is `orange`\n\n'
descriptionLineCount="6"
file="bin/build/install.sample.sh"
fn="__usageMessageStyle"
fnMarker="__usagemessagestyle"
foundNames=([0]="summary" [1]="argument" [2]="local")
line="1034"
local=$'style\n'
original="__usageMessageStyle"
rawComment=$'Summary: Style usage messages\nFormat arguments using the usage message return code to style output.\nArgument: returnCode - UnsignedInteger. Required. Return code to use as the basis for styling output.\n- `0` - meaning no error, style is `info`\n- `1` - Environment error, style is `error`\n- `2` - Argument error, style is `red`\n- `*` - All additional errors, style is `orange`\nLocal: style\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/install.sample.sh"
sourceHash="cc6a7bc654dc526a77adef2258e0e353f853addb"
sourceLine="1034"
summary="Style usage messages"
summaryComputed=""
usage="__usageMessageStyle returnCode"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__usageMessageStyle'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mreturnCode'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mreturnCode  '$'\e''[[(value)]mUnsignedInteger. Required. Return code to use as the basis for styling output.'$'\e''[[(reset)]m'$'\n'''$'\n''Format arguments using the usage message return code to style output.'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - meaning no error, style is '$'\e''[[(code)]minfo'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error, style is '$'\e''[[(code)]merror'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error, style is '$'\e''[[(code)]mred'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]m'$'\e''[[(cyan)]m'$'\e''[[(reset)]m - All additional errors, style is '$'\e''[[(code)]morange'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __usageMessageStyle returnCode'$'\n'''$'\n''    returnCode  UnsignedInteger. Required. Return code to use as the basis for styling output.'$'\n'''$'\n''Format arguments using the usage message return code to style output.'$'\n''- 0 - meaning no error, style is info'$'\n''- 1 - Environment error, style is error'$'\n''- 2 - Argument error, style is red'$'\n''-  - All additional errors, style is orange'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/usage.md"
