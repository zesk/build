#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="\`prefix\` - Optional prefix for token search, defaults to \`{\` (same as \`map.sh\`)"$'\n'"\`suffix\` - Optional suffix for token search, defaults to \`}\` (same as \`map.sh\`)"$'\n'""
base="map.sh"
depends="sed quoteSedPattern"$'\n'""
description="Short description: list mappable variables in a file (without prefix or suffix)"$'\n'""
environment="None."$'\n'""
file="bin/build/tools/map.sh"
fn="mapTokens"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceModified="1768756695"
summary="Short description: list mappable variables in a file (without prefix"
usage="mapTokens [ \`prefix\` ] [ \`suffix\` ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmapTokens[0m [94m[ `prefix` ][0m [94m[ `suffix` ][0m

    [94m[38;2;0;255;0;48;2;0;0;0mprefix[0m  [1;97mOptional prefix for token search, defaults to [38;2;0;255;0;48;2;0;0;0m{[0m (same as [38;2;0;255;0;48;2;0;0;0mmap.sh[0m)[0m
    [94m[38;2;0;255;0;48;2;0;0;0msuffix[0m  [1;97mOptional suffix for token search, defaults to [38;2;0;255;0;48;2;0;0;0m}[0m (same as [38;2;0;255;0;48;2;0;0;0mmap.sh[0m)[0m

Short description: list mappable variables in a file (without prefix or suffix)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- None.
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: mapTokens [ `prefix` ] [ `suffix` ]

    prefix  Optional prefix for token search, defaults to { (same as map.sh)
    suffix  Optional suffix for token search, defaults to } (same as map.sh)

Short description: list mappable variables in a file (without prefix or suffix)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- None.
- 
'
