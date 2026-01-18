#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"--help - Flag. Optional. Display this help."$'\n'"text - EmptyString. Required. text to convert to uppercase"$'\n'""
base="text.sh"
description="Convert text to uppercase"$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="uppercase"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
requires="tr"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768721469"
stdout="\`String\`. The uppercase version of the \`text\`."$'\n'""
summary="Convert text to uppercase"
usage="uppercase [ -- ] [ --help ] text"
