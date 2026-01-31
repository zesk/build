#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"Argument: --suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"Argument: --token - String. Optional. Classes permitted in a token"$'\n'"Argument: text - String. Optional. Text to search for mapping tokens."$'\n'"Return code: - \`0\` - Text contains mapping tokens"$'\n'"Return code: - \`1\` - Text does not contain mapping tokens"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"Argument: --suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"Argument: --token - String. Optional. Classes permitted in a token"$'\n'"Argument: text - String. Optional. Text to search for mapping tokens."$'\n'"Return code: - \`0\` - Text contains mapping tokens"$'\n'"Return code: - \`1\` - Text does not contain mapping tokens"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Check if text contains mappable tokens"
usage="isMappable"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misMappable'$'\e''[0m'$'\n'''$'\n''Check if text contains mappable tokens'$'\n''If any text passed contains a token which can be mapped, succeed.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --prefix - String. Optional. Token prefix defaults to '$'\e''[[(code)]m{'$'\e''[[(reset)]m.'$'\n''Argument: --suffix - String. Optional. Token suffix defaults to '$'\e''[[(code)]m}'$'\e''[[(reset)]m.'$'\n''Argument: --token - String. Optional. Classes permitted in a token'$'\n''Argument: text - String. Optional. Text to search for mapping tokens.'$'\n''Return code: - '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text contains mapping tokens'$'\n''Return code: - '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text does not contain mapping tokens'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isMappable'$'\n'''$'\n''Check if text contains mappable tokens'$'\n''If any text passed contains a token which can be mapped, succeed.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --prefix - String. Optional. Token prefix defaults to {.'$'\n''Argument: --suffix - String. Optional. Token suffix defaults to }.'$'\n''Argument: --token - String. Optional. Classes permitted in a token'$'\n''Argument: text - String. Optional. Text to search for mapping tokens.'$'\n''Return code: - 0 - Text contains mapping tokens'$'\n''Return code: - 1 - Text does not contain mapping tokens'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.482
