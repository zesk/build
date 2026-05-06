#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="\`prefix\` - Optional prefix for token search, defaults to \`{\` (same as \`map.sh\`)"$'\n'"\`suffix\` - Optional suffix for token search, defaults to \`}\` (same as \`map.sh\`)"$'\n'""
base="map.sh"
depends="sed quoteSedPattern"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="No documentation for \`mapTokens\`."$'\n'""
descriptionLineCount=""
environment="None."$'\n'""
file="bin/build/tools/map.sh"
fn="mapTokens"
fnMarker="maptokens"
foundNames=([0]="argument" [1]="environment" [2]="short_description" [3]="depends")
line="115"
rawComment="Argument: \`prefix\` - Optional prefix for token search, defaults to \`{\` (same as \`map.sh\`)"$'\n'"Argument: \`suffix\` - Optional suffix for token search, defaults to \`}\` (same as \`map.sh\`)"$'\n'"Environment: None."$'\n'"Short description: list mappable variables in a file (without prefix or suffix)"$'\n'"Depends: sed quoteSedPattern"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
short_description="list mappable variables in a file (without prefix or suffix)"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="940f9ebf8bd346b36b369627516a0d1367a6cdfa"
sourceLine="115"
summary="undocumented"
summaryComputed=""
usage="mapTokens [ \`prefix\` ] [ \`suffix\` ]"
