#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="map.sh"
description="Argument: \`prefix\` - Optional prefix for token search, defaults to \`{\` (same as \`map.sh\`)"$'\n'"Argument: \`suffix\` - Optional suffix for token search, defaults to \`}\` (same as \`map.sh\`)"$'\n'"Environment: None."$'\n'"Short description: list mappable variables in a file (without prefix or suffix)"$'\n'"Depends: sed quoteSedPattern"$'\n'"shellcheck disable=SC2120"$'\n'""
file="bin/build/tools/map.sh"
foundNames=()
rawComment="Argument: \`prefix\` - Optional prefix for token search, defaults to \`{\` (same as \`map.sh\`)"$'\n'"Argument: \`suffix\` - Optional suffix for token search, defaults to \`}\` (same as \`map.sh\`)"$'\n'"Environment: None."$'\n'"Short description: list mappable variables in a file (without prefix or suffix)"$'\n'"Depends: sed quoteSedPattern"$'\n'"shellcheck disable=SC2120"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="f0c857d63d28b28b6a1200dec8c23530ae6c78d6"
summary="Argument: \`prefix\` - Optional prefix for token search, defaults to"
usage="mapTokens"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmapTokens'$'\e''[0m'$'\n'''$'\n''Argument: '$'\e''[[(code)]mprefix'$'\e''[[(reset)]m - Optional prefix for token search, defaults to '$'\e''[[(code)]m{'$'\e''[[(reset)]m (same as '$'\e''[[(code)]mmap.sh'$'\e''[[(reset)]m)'$'\n''Argument: '$'\e''[[(code)]msuffix'$'\e''[[(reset)]m - Optional suffix for token search, defaults to '$'\e''[[(code)]m}'$'\e''[[(reset)]m (same as '$'\e''[[(code)]mmap.sh'$'\e''[[(reset)]m)'$'\n''Environment: None.'$'\n''Short description: list mappable variables in a file (without prefix or suffix)'$'\n''Depends: sed quoteSedPattern'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mapTokens'$'\n'''$'\n''Argument: prefix - Optional prefix for token search, defaults to { (same as map.sh)'$'\n''Argument: suffix - Optional suffix for token search, defaults to } (same as map.sh)'$'\n''Environment: None.'$'\n''Short description: list mappable variables in a file (without prefix or suffix)'$'\n''Depends: sed quoteSedPattern'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.475
