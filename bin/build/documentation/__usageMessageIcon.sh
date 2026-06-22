#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument="none"
base="install.sample.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'- `0` - meaning no error, icon is `🏆`\n- non-`0` - Error, icon is `❌`\n\n'
descriptionLineCount="3"
file="bin/build/install.sample.sh"
fn="__usageMessageIcon"
fnMarker="__usagemessageicon"
foundNames=([0]="summary" [1]="local")
line="1022"
local=$'icon\n'
original="__usageMessageIcon"
rawComment=$'Summary: Icon for usage messages\n- `0` - meaning no error, icon is `🏆`\n- non-`0` - Error, icon is `❌`\nLocal: icon\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/install.sample.sh"
sourceHash="cc6a7bc654dc526a77adef2258e0e353f853addb"
sourceLine="1022"
summary="Icon for usage messages"
summaryComputed=""
usage="__usageMessageIcon"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__usageMessageIcon'$'\e''[0m'$'\n'''$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - meaning no error, icon is '$'\e''[[(code)]m🏆'$'\e''[[(reset)]m'$'\n''- non-'$'\e''[[(code)]m0'$'\e''[[(reset)]m - Error, icon is '$'\e''[[(code)]m❌'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __usageMessageIcon'$'\n'''$'\n''- 0 - meaning no error, icon is 🏆'$'\n''- non-0 - Error, icon is ❌'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
