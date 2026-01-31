#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"--suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"--token - String. Optional. Classes permitted in a token"$'\n'"text - String. Optional. Text to search for mapping tokens."$'\n'""
base="text.sh"
description="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"Argument: --suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"Argument: --token - String. Optional. Classes permitted in a token"$'\n'"Argument: text - String. Optional. Text to search for mapping tokens."$'\n'"Return code: - \`0\` - Text contains mapping tokens"$'\n'"Return code: - \`1\` - Text does not contain mapping tokens"$'\n'""$'\n'""
return_code="- \`0\` - Text contains mapping tokens"$'\n'"- \`1\` - Text does not contain mapping tokens"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Check if text contains mappable tokens"
summaryComputed="true"
usage="isMappable [ --help ] [ --prefix ] [ --suffix ] [ --token ] [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misMappable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --suffix ]'$'\e''[0m '$'\e''[[(blue)]m[ --token ]'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix  '$'\e''[[(value)]mString. Optional. Token prefix defaults to '$'\e''[[(code)]m{'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--suffix  '$'\e''[[(value)]mString. Optional. Token suffix defaults to '$'\e''[[(code)]m}'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--token   '$'\e''[[(value)]mString. Optional. Classes permitted in a token'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext      '$'\e''[[(value)]mString. Optional. Text to search for mapping tokens.'$'\e''[[(reset)]m'$'\n'''$'\n''Check if text contains mappable tokens'$'\n''If any text passed contains a token which can be mapped, succeed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text contains mapping tokens'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text does not contain mapping tokens'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]misMappable [[(blue)]m[ --help ] [[(blue)]m[ --prefix ] [[(blue)]m[ --suffix ] [[(blue)]m[ --token ] [[(blue)]m[ text ]'$'\n'''$'\n''    [[(blue)]m--help    [[(value)]mFlag. Optional. Display this help.[[(reset)]m'$'\n''    [[(blue)]m--prefix  [[(value)]mString. Optional. Token prefix defaults to [[(code)]m{[[(reset)]m.[[(reset)]m'$'\n''    [[(blue)]m--suffix  [[(value)]mString. Optional. Token suffix defaults to [[(code)]m}[[(reset)]m.[[(reset)]m'$'\n''    [[(blue)]m--token   [[(value)]mString. Optional. Classes permitted in a token[[(reset)]m'$'\n''    [[(blue)]mtext      [[(value)]mString. Optional. Text to search for mapping tokens.[[(reset)]m'$'\n'''$'\n''Check if text contains mappable tokens'$'\n''If any text passed contains a token which can be mapped, succeed.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Text contains mapping tokens'$'\n''- [[(code)]m1[[(reset)]m - Text does not contain mapping tokens'$'\n'''
# elapsed 3.582
