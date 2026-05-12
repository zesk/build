#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'`prefix` - Optional prefix for token search, defaults to `{` (same as `map.sh`)\n`suffix` - Optional suffix for token search, defaults to `}` (same as `map.sh`)\n'
base="map.sh"
depends=$'sed quoteSedPattern\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'No documentation for `mapTokens`.\n'
descriptionLineCount=""
environment=$'None.\n'
file="bin/build/tools/map.sh"
fn="mapTokens"
fnMarker="maptokens"
foundNames=([0]="argument" [1]="environment" [2]="short_description" [3]="depends")
line="115"
rawComment=$'Argument: `prefix` - Optional prefix for token search, defaults to `{` (same as `map.sh`)\nArgument: `suffix` - Optional suffix for token search, defaults to `}` (same as `map.sh`)\nEnvironment: None.\nShort description: list mappable variables in a file (without prefix or suffix)\nDepends: sed quoteSedPattern\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
short_description=$'list mappable variables in a file (without prefix or suffix)\n'
sourceFile="bin/build/tools/map.sh"
sourceHash="ad239b6bc25f5b8d6c7ef606feeaa9161fae799e"
sourceLine="115"
summary="undocumented"
summaryComputed=""
usage="mapTokens [ \`prefix\` ] [ \`suffix\` ]"
