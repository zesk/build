#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-19
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"value - String. Optional. Value to check if it is a boolean."$'\n'""
base="_sugar.sh"
description="Boolean test"$'\n'"If you want \"true-ish\" use \`isTrue\`."$'\n'"Returns 0 if \`value\` is boolean \`false\` or \`true\`."$'\n'"Is this a boolean? (\`true\` or \`false\`)"$'\n'"Return Code: 0 - if value is a boolean"$'\n'"Return Code: 1 - if value is not a boolean"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="isBoolean"
foundNames=([0]="see" [1]="argument" [2]="requires")
requires="usageDocument printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="isTrue parseBoolean"$'\n'""
source="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Boolean test"
usage="isBoolean [ --help ] [ value ]"
