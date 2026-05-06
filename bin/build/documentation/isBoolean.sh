#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"value - String. Optional. Value to check if it is a boolean."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Boolean test"$'\n'"If you want \"true-ish\" use \`isTrue\`."$'\n'"Returns 0 if \`value\` is boolean \`false\` oHar \`true\`."$'\n'"Is this a boolean? (\`true\` or \`false\`)"$'\n'""$'\n'""
descriptionLineCount="5"
file="bin/build/tools/_sugar.sh"
fn="isBoolean"
fnMarker="isboolean"
foundNames=([0]="return_code" [1]="see" [2]="argument" [3]="requires")
line="79"
rawComment="Boolean test"$'\n'"If you want \"true-ish\" use \`isTrue\`."$'\n'"Returns 0 if \`value\` is boolean \`false\` oHar \`true\`."$'\n'"Is this a boolean? (\`true\` or \`false\`)"$'\n'"Return Code: 0 - if value is a boolean"$'\n'"Return Code: 1 - if value is not a boolean"$'\n'"See: isTrue booleanParse"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - String. Optional. Value to check if it is a boolean."$'\n'"Requires: bashDocumentation"$'\n'""$'\n'""
requires="bashDocumentation"$'\n'""
return_code="0 - if value is a boolean"$'\n'"1 - if value is not a boolean"$'\n'""
see="isTrue booleanParse"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="a07159f0d529eb650133ee48b457cb1ccff3f0d5"
sourceLine="79"
summary="Boolean test"
summaryComputed="true"
usage="isBoolean [ --help ] [ value ]"
