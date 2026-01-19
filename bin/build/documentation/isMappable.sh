#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"--suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"--token - String. Optional. Classes permitted in a token"$'\n'"text - String. Optional. Text to search for mapping tokens."$'\n'""
base="text.sh"
description="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'"Return code: - \`0\` - Text contains mapping tokens"$'\n'"Return code: - \`1\` - Text does not contain mapping tokens"$'\n'""
file="bin/build/tools/text.sh"
fn="isMappable"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768776345"
summary="Check if text contains mappable tokens"
usage="isMappable [ --help ] [ --prefix ] [ --suffix ] [ --token ] [ text ]"
