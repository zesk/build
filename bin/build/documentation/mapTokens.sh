#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="\`prefix\` - Optional prefix for token search, defaults to \`{\` (same as \`map.sh\`)"$'\n'"\`suffix\` - Optional suffix for token search, defaults to \`}\` (same as \`map.sh\`)"$'\n'""
base="map.sh"
depends="sed quoteSedPattern"$'\n'""
description="Short description: list mappable variables in a file (without prefix or suffix)"$'\n'""
environment="None."$'\n'""
file="bin/build/tools/map.sh"
fn="mapTokens"
foundNames=([0]="argument" [1]="environment" [2]="depends")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/map.sh"
sourceModified="1768695708"
summary="Short description: list mappable variables in a file (without prefix"
usage="mapTokens [ \`prefix\` ] [ \`suffix\` ]"
