#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Check if text contains plaintext only."$'\n'"Argument: text - String. Required. Text to search for mapping tokens."$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Check if text contains plaintext only."$'\n'"Argument: text - String. Required. Text to search for mapping tokens."$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Check if text contains plaintext only."
usage="isPlain"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPlain'$'\e''[0m'$'\n'''$'\n''Check if text contains plaintext only.'$'\n''Argument: text - String. Required. Text to search for mapping tokens.'$'\n''Without arguments, displays help.'$'\n''Return code: - '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text is plain'$'\n''Return code: - '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text contains non-plain characters'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isPlain'$'\n'''$'\n''Check if text contains plaintext only.'$'\n''Argument: text - String. Required. Text to search for mapping tokens.'$'\n''Without arguments, displays help.'$'\n''Return code: - 0 - Text is plain'$'\n''Return code: - 1 - Text contains non-plain characters'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.482
