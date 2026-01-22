#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - String. Optional. String to match."$'\n'"prefixText - String. Required. One or more. Does this prefix exist in our \`text\`?"$'\n'""
base="text.sh"
description="Return Code: 0 - If \`text\` has any prefix"$'\n'"Does text have one or more prefixes?"$'\n'""
file="bin/build/tools/text.sh"
fn="beginsWith"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
summary="Return Code: 0 - If \`text\` has any prefix"
usage="beginsWith [ text ] prefixText"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbeginsWith[0m [94m[ text ][0m [38;2;255;255;0m[35;48;2;0;0;0mprefixText[0m[0m

    [94mtext        [1;97mString. Optional. String to match.[0m
    [31mprefixText  [1;97mString. Required. One or more. Does this prefix exist in our [38;2;0;255;0;48;2;0;0;0mtext[0m?[0m

Return Code: 0 - If [38;2;0;255;0;48;2;0;0;0mtext[0m has any prefix
Does text have one or more prefixes?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: beginsWith [ text ] prefixText

    text        String. Optional. String to match.
    prefixText  String. Required. One or more. Does this prefix exist in our text?

Return Code: 0 - If text has any prefix
Does text have one or more prefixes?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
