#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="-- -  Flag. Optional.Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"--help -  Flag. Optional.Display this help."$'\n'"text - EmptyString. Required. Text to convert to lowercase"$'\n'""
base="text.sh"
description="Convert text to lowercase"$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="lowercase"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
requires="tr"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768686587"
stdout="\`String\`. The lowercase version of the \`text\`."$'\n'""
summary="Convert text to lowercase"
usage="lowercase [ -- ] [ --help ] text"
