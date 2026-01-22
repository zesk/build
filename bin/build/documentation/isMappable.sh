#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"--suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"--token - String. Optional. Classes permitted in a token"$'\n'"text - String. Optional. Text to search for mapping tokens."$'\n'""
base="text.sh"
description="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'"Return code: - \`0\` - Text contains mapping tokens"$'\n'"Return code: - \`1\` - Text does not contain mapping tokens"$'\n'""
file="bin/build/tools/text.sh"
fn="isMappable"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
summary="Check if text contains mappable tokens"
usage="isMappable [ --help ] [ --prefix ] [ --suffix ] [ --token ] [ text ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misMappable[0m [94m[ --help ][0m [94m[ --prefix ][0m [94m[ --suffix ][0m [94m[ --token ][0m [94m[ text ][0m

    [94m--help    [1;97mFlag. Optional. Display this help.[0m
    [94m--prefix  [1;97mString. Optional. Token prefix defaults to [38;2;0;255;0;48;2;0;0;0m{[0m.[0m
    [94m--suffix  [1;97mString. Optional. Token suffix defaults to [38;2;0;255;0;48;2;0;0;0m}[0m.[0m
    [94m--token   [1;97mString. Optional. Classes permitted in a token[0m
    [94mtext      [1;97mString. Optional. Text to search for mapping tokens.[0m

Check if text contains mappable tokens
If any text passed contains a token which can be mapped, succeed.
Return code: - [38;2;0;255;0;48;2;0;0;0m0[0m - Text contains mapping tokens
Return code: - [38;2;0;255;0;48;2;0;0;0m1[0m - Text does not contain mapping tokens

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isMappable [ --help ] [ --prefix ] [ --suffix ] [ --token ] [ text ]

    --help    Flag. Optional. Display this help.
    --prefix  String. Optional. Token prefix defaults to {.
    --suffix  String. Optional. Token suffix defaults to }.
    --token   String. Optional. Classes permitted in a token
    text      String. Optional. Text to search for mapping tokens.

Check if text contains mappable tokens
If any text passed contains a token which can be mapped, succeed.
Return code: - 0 - Text contains mapping tokens
Return code: - 1 - Text does not contain mapping tokens

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
