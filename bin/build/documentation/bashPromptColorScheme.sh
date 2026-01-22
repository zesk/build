#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt.sh"
argument="colorScheme - String. Optional. Color scheme to choose: \`light\`, \`dark\`, \`forest\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="prompt.sh"
description="Color schemes for prompts"$'\n'"Options are:"$'\n'"- forest"$'\n'"- light (default)"$'\n'"- dark"$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptColorScheme"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceModified="1768775409"
summary="Color schemes for prompts"
usage="bashPromptColorScheme [ colorScheme ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashPromptColorScheme[0m [94m[ colorScheme ][0m [94m[ --help ][0m

    [94mcolorScheme  [1;97mString. Optional. Color scheme to choose: [38;2;0;255;0;48;2;0;0;0mlight[0m, [38;2;0;255;0;48;2;0;0;0mdark[0m, [38;2;0;255;0;48;2;0;0;0mforest[0m[0m
    [94m--help       [1;97mFlag. Optional. Display this help.[0m

Color schemes for prompts
Options are:
- forest
- light (default)
- dark

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptColorScheme [ colorScheme ] [ --help ]

    colorScheme  String. Optional. Color scheme to choose: light, dark, forest
    --help       Flag. Optional. Display this help.

Color schemes for prompts
Options are:
- forest
- light (default)
- dark

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
