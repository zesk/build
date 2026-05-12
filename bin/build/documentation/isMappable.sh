#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"--suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"--token - String. Optional. Classes permitted in a token"$'\n'"text - String. Optional. Text to search for mapping tokens."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="isMappable"
fnMarker="ismappable"
foundNames=([0]="argument" [1]="return_code")
line="114"
rawComment="Check if text contains mappable tokens"$'\n'"If any text passed contains a token which can be mapped, succeed."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"Argument: --suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"Argument: --token - String. Optional. Classes permitted in a token"$'\n'"Argument: text - String. Optional. Text to search for mapping tokens."$'\n'"Return code: - \`0\` - Text contains mapping tokens"$'\n'"Return code: - \`1\` - Text does not contain mapping tokens"$'\n'""$'\n'""
return_code="- \`0\` - Text contains mapping tokens"$'\n'"- \`1\` - Text does not contain mapping tokens"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="114"
summary="Check if text contains mappable tokens"
summaryComputed="true"
usage="isMappable [ --help ] [ --prefix ] [ --suffix ] [ --token ] [ text ]"
