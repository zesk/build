#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="alternateChar - String. Optional. Use an alternate character or string output"$'\n'"offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is \`0\`)"$'\n'""
base="decoration.sh"
description="Output a bar as wide as the console using the \`=\` symbol."$'\n'""
example="    decorate success \$(echoBar =-)"$'\n'"    decorate success \$(echoBar \"- Success \")"$'\n'"    decorate magenta \$(echoBar +-)"$'\n'""
file="bin/build/tools/decoration.sh"
fn="echoBar"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="consoleColumns"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="Output a bar as wide as the console"$'\n'""
usage="echoBar [ alternateChar ] [ offset ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mechoBar[0m [94m[ alternateChar ][0m [94m[ offset ][0m

    [94malternateChar  [1;97mString. Optional. Use an alternate character or string output[0m
    [94moffset         [1;97mInteger. Optional. an integer offset to increase or decrease the size of the bar (default is [38;2;0;255;0;48;2;0;0;0m0[0m)[0m

Output a bar as wide as the console using the [38;2;0;255;0;48;2;0;0;0m=[0m symbol.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    decorate success $(echoBar =-)
    decorate success $(echoBar "- Success ")
    decorate magenta $(echoBar +-)
'
# shellcheck disable=SC2016
helpPlain='Usage: echoBar [ alternateChar ] [ offset ]

    alternateChar  String. Optional. Use an alternate character or string output
    offset         Integer. Optional. an integer offset to increase or decrease the size of the bar (default is 0)

Output a bar as wide as the console using the = symbol.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    decorate success $(echoBar =-)
    decorate success $(echoBar "- Success ")
    decorate magenta $(echoBar +-)
'
