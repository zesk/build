#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"prefix - EmptyString. Optional. Prefix for all prompts."$'\n'"suffix - EmptyString. Optional. Suffix for all prompts."$'\n'""
base="prompt.sh"
description="Set markers for terminal integration"$'\n'"Outputs the current marker settings, one per line (0, 1, or 2 lines will be output)."$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptMarkers"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceModified="1768775409"
summary="Set markers for terminal integration"
usage="bashPromptMarkers [ --help ] [ prefix ] [ suffix ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashPromptMarkers[0m [94m[ --help ][0m [94m[ prefix ][0m [94m[ suffix ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mprefix  [1;97mEmptyString. Optional. Prefix for all prompts.[0m
    [94msuffix  [1;97mEmptyString. Optional. Suffix for all prompts.[0m

Set markers for terminal integration
Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptMarkers [ --help ] [ prefix ] [ suffix ]

    --help  Flag. Optional. Display this help.
    prefix  EmptyString. Optional. Prefix for all prompts.
    suffix  EmptyString. Optional. Suffix for all prompts.

Set markers for terminal integration
Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
