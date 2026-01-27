#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"--suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"--token - String. Optional. Classes permitted in a token"$'\n'"text - String. Optional. Text to search for mapping tokens."$'\n'""
base="text.sh"
description="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"Argument: --suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"Argument: --token - String. Optional. Classes permitted in a token"$'\n'"Argument: text - String. Optional. Text to search for mapping tokens."$'\n'"Return code: - \`0\` - Text contains mapping tokens"$'\n'"Return code: - \`1\` - Text does not contain mapping tokens"$'\n'""$'\n'""
return_code="- \`0\` - Text contains mapping tokens"$'\n'"- \`1\` - Text does not contain mapping tokens"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769320918"
summary="Check if text contains mappable tokens"
usage="isMappable [ --help ] [ --prefix ] [ --suffix ] [ --token ] [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misMappable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --suffix ]'$'\e''[0m '$'\e''[[(blue)]m[ --token ]'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix  '$'\e''[[(value)]mString. Optional. Token prefix defaults to '$'\e''[[(code)]m{'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--suffix  '$'\e''[[(value)]mString. Optional. Token suffix defaults to '$'\e''[[(code)]m}'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--token   '$'\e''[[(value)]mString. Optional. Classes permitted in a token'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext      '$'\e''[[(value)]mString. Optional. Text to search for mapping tokens.'$'\e''[[(reset)]m'$'\n'''$'\n''Check if text contains mappable tokens'$'\n''If any text passed contains a token which can be mapped, succeed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text contains mapping tokens'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text does not contain mapping tokens'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isMappable [ --help ] [ --prefix ] [ --suffix ] [ --token ] [ text ]'$'\n'''$'\n''    --help    Flag. Optional. Display this help.'$'\n''    --prefix  String. Optional. Token prefix defaults to {.'$'\n''    --suffix  String. Optional. Token suffix defaults to }.'$'\n''    --token   String. Optional. Classes permitted in a token'$'\n''    text      String. Optional. Text to search for mapping tokens.'$'\n'''$'\n''Check if text contains mappable tokens'$'\n''If any text passed contains a token which can be mapped, succeed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Text contains mapping tokens'$'\n''- 1 - Text does not contain mapping tokens'$'\n'''
# elapsed 0.493
