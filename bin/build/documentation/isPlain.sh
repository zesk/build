#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="text - String. Required. Text to search for mapping tokens."$'\n'""
base="text.sh"
description="Check if text contains plaintext only."$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Check if text contains plaintext only."$'\n'"Argument: text - String. Required. Text to search for mapping tokens."$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""$'\n'""
return_code="- \`0\` - Text is plain"$'\n'"- \`1\` - Text contains non-plain characters"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Check if text contains plaintext only."
summaryComputed="true"
usage="isPlain text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPlain'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mString. Required. Text to search for mapping tokens.'$'\e''[[(reset)]m'$'\n'''$'\n''Check if text contains plaintext only.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text is plain'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text contains non-plain characters'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]misPlain [[(bold)]m[[(magenta)]mtext'$'\n'''$'\n''    text  [[(value)]mString. Required. Text to search for mapping tokens.'$'\n'''$'\n''Check if text contains plaintext only.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Text is plain'$'\n''- [[(code)]m1 - Text contains non-plain characters'$'\n'''
# elapsed 3.17
