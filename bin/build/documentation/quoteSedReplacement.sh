#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sed.sh"
argument="text - EmptyString. Required. Text to quote"$'\n'"separatorChar - The character used to separate the sed pattern and replacement. Defaults to \`/\`."$'\n'""
base="sed.sh"
description="Quote sed replacement strings for shell use"$'\n'""
example="    sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedReplacement \"\$2\")/g\""$'\n'"    needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'""
file="bin/build/tools/sed.sh"
fn="quoteSedReplacement"
foundNames=""
needSlash=""
output="string quoted and appropriate to insert in a \`sed\` replacement phrase"$'\n'""
requires="printf sed usageDocument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceModified="1768683999"
summary="Quote sed replacement strings for shell use"$'\n'""
usage="quoteSedReplacement text [ separatorChar ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mquoteSedReplacement[0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m [94m[ separatorChar ][0m

    [31mtext           [1;97mEmptyString. Required. Text to quote[0m
    [94mseparatorChar  [1;97mThe character used to separate the sed pattern and replacement. Defaults to [38;2;0;255;0;48;2;0;0;0m/[0m.[0m

Quote sed replacement strings for shell use

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"
    needSlash=$(quoteSedPattern '\''$.[36m/[\]^'\'')[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: quoteSedReplacement text [ separatorChar ]

    text           EmptyString. Required. Text to quote
    separatorChar  The character used to separate the sed pattern and replacement. Defaults to /.

Quote sed replacement strings for shell use

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"
    needSlash=$(quoteSedPattern '\''$./[\]^'\'')
'
