#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="\`prefix\` - Optional prefix for token search, defaults to \`{\` (same as \`map.sh\`)"$'\n'"\`suffix\` - Optional suffix for token search, defaults to \`}\` (same as \`map.sh\`)"$'\n'""
base="map.sh"
depends="sed quoteSedPattern"$'\n'""
description="No documentation for \`mapTokens\`."$'\n'""
environment="None."$'\n'""
exitCode="0"
file="bin/build/tools/map.sh"
foundNames=([0]="argument" [1]="environment" [2]="short_description" [3]="depends")
rawComment="Argument: \`prefix\` - Optional prefix for token search, defaults to \`{\` (same as \`map.sh\`)"$'\n'"Argument: \`suffix\` - Optional suffix for token search, defaults to \`}\` (same as \`map.sh\`)"$'\n'"Environment: None."$'\n'"Short description: list mappable variables in a file (without prefix or suffix)"$'\n'"Depends: sed quoteSedPattern"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
short_description="list mappable variables in a file (without prefix or suffix)"$'\n'""
sourceModified="1769063211"
summary="undocumented"
usage="mapTokens [ \`prefix\` ] [ \`suffix\` ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mmapTokens'$'\e''[0m '$'\e''[[blue]m[ `prefix` ]'$'\e''[0m '$'\e''[[blue]m[ `suffix` ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m'$'\e''[[code]mprefix'$'\e''[[reset]m  '$'\e''[[value]mOptional prefix for token search, defaults to '$'\e''[[code]m{'$'\e''[[reset]m (same as '$'\e''[[code]mmap.sh'$'\e''[[reset]m)'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m'$'\e''[[code]msuffix'$'\e''[[reset]m  '$'\e''[[value]mOptional suffix for token search, defaults to '$'\e''[[code]m}'$'\e''[[reset]m (same as '$'\e''[[code]mmap.sh'$'\e''[[reset]m)'$'\e''[[reset]m'$'\n'''$'\n''No documentation for '$'\e''[[code]mmapTokens'$'\e''[[reset]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- None.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mapTokens [ `prefix` ] [ `suffix` ]'$'\n'''$'\n''    prefix  Optional prefix for token search, defaults to { (same as map.sh)'$'\n''    suffix  Optional suffix for token search, defaults to } (same as map.sh)'$'\n'''$'\n''No documentation for mapTokens.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- None.'$'\n'''
